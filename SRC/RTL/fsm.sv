//FSM Moore

`timescale 1ns/1ps

module fsm import ascon_pack::*;
	(
	 	input logic clock_i,
	 	input logic resetb_i,

		input logic[3:0] round_i,

		input logic start_i,
		input logic data_valid_i,
		

		output logic cipher_valid_o,
		output logic end_o,

		output logic input_select_o,
		output logic ena_xor_up_o,
		output logic ena_xor_down_o,
		output logic ena_reg_state_o,

		output logic[1:0] conf_xor_down_o,

		output logic init_a_o,
		output logic init_b_o,
		output logic ena_cpt_o	

	);


	// Énumération des différents états de la FSM
	typedef enum {idle, set_cpt, init_state, init, end_init, wait_a1, xor_a1, da, end_da, wait_p1, xor_p1, tc1, end_tc1, wait_p2, xor_p2, tc2, end_tc2, wait_p3, xor_p3, finalisation, end_finalisation, xor_final, fin} fsm_state;

	// États courant et suivant
	fsm_state current_state_s, next_state_s;

	always_ff @(posedge clock_i or negedge resetb_i) 
		begin : seq_0
			if (resetb_i == 1'b0) begin
				current_state_s <= idle; // Retour à l'état idle si resetb_i est actif
			end
			else begin current_state_s <= next_state_s; // Sinon, transition vers l'état suivant
			end
	end : seq_0


	// Logique de transition entre les états
	always_comb begin : OUTPUT_STATE
		case (current_state_s)
			idle: begin 
			if (start_i == 1'b0) next_state_s = idle;
			else next_state_s = set_cpt;
			end
			
			set_cpt: begin 
			next_state_s = init_state;
			end

			init_state: begin 
			next_state_s = init;
			end

			init: begin 
			if (round_i == 4'hA) next_state_s = end_init;
			else next_state_s = init;
			end 

			end_init: begin 
			if (data_valid_i == 1'b1) next_state_s = xor_a1;
			else next_state_s = wait_a1;
			end 

			wait_a1: begin 
			if (data_valid_i == 1'b1) next_state_s = xor_a1;
			else next_state_s = wait_a1;
			end
			
			xor_a1: begin 
			next_state_s = da;
			end

			da : begin 
			if (round_i == 4'hA) next_state_s = end_da;
			else next_state_s = da;
			end 

			end_da: begin 
			if (data_valid_i == 1'b1) next_state_s = xor_p1;
			else next_state_s = wait_p1;
			end 

			xor_p1: begin 
			next_state_s = tc1;
			end

			wait_p1: begin 
			if (data_valid_i == 1'b1) next_state_s = xor_p1;
			else next_state_s = wait_p1;
			end

			tc1 : begin 
			if (round_i == 4'hA) next_state_s = end_tc1;
			else next_state_s = tc1;
			end 

			end_tc1 : begin
			if (data_valid_i == 1'b1) next_state_s = xor_p2;
			else next_state_s = wait_p2;
			end

			xor_p2: begin 
			next_state_s = tc2;
			end

			wait_p2: begin 
			if (data_valid_i == 1'b1) next_state_s = xor_p2;
			else next_state_s = wait_p2;
			end

			tc2 : begin 
			if (round_i == 4'hA) next_state_s = end_tc2;
			else next_state_s = tc2;
			end 

			end_tc2: begin 
			if (data_valid_i == 1'b1) next_state_s = xor_p3;
			else next_state_s = wait_p3;
			end 

			xor_p3: begin 
			next_state_s = finalisation;
			end

			wait_p3: begin 
			if (data_valid_i == 1'b1) next_state_s = xor_p3;
			else next_state_s = wait_p3;
			end

			finalisation: begin 
			if (round_i == 4'hA) next_state_s = end_finalisation;
			else next_state_s = finalisation;
			end

			end_finalisation: begin 
			next_state_s = xor_final;
			end

			xor_final: begin 
			next_state_s = fin;
			end

			fin: begin 
			next_state_s = idle;
			end

		endcase
	end : OUTPUT_STATE

	// Logique de gestion des sorties en fonction de l'état courant
	always_comb begin : OUTPUT_LOGIC

		// Valeurs par défaut pour les sorties
        	cipher_valid_o  = 1'b0;
        	end_o           = 1'b0;
        	input_select_o  = 1'b0;
        	ena_cpt_o       = 1'b0;
        	init_a_o        = 1'b0;
     	   	init_b_o        = 1'b0;
       	 	ena_xor_up_o    = 1'b0;
        	ena_xor_down_o  = 1'b0;
        	conf_xor_down_o = 2'b00;
        	ena_reg_state_o = 1'b1; // L'enregistrement de l'état est activé par défaut


		case (current_state_s)
			idle: begin 
			ena_reg_state_o = 1'b0;
			end
			
			set_cpt: begin 
			init_a_o = 1'b1; // Initialise le compteur à 0
			ena_cpt_o = 1'b1; // Active le compteur 
			ena_reg_state_o = 1'b0;
			end

			init_state: begin 
			input_select_o = 1'b1; //Initialise état avec IV, K, N
			ena_cpt_o = 1'b1; // Maintient le compteur actif
			end

			init: begin 
			ena_cpt_o = 1'b1; //Maintient le compteur actif
			end

			end_init: begin
			ena_xor_down_o = 1'b1; //Active XOR DOWN à la fin de la phase d'initialisation
			init_b_o = 1'b1; // Initialise le compteur à 6
			ena_cpt_o = 1'b1; //Maintient le compteur actif
			end 

			xor_a1: begin 
			ena_cpt_o = 1'b1; 
			ena_xor_up_o = 1'b1; //Active XOR UP au début de la phase "donnée associée"
			end 

			wait_a1: begin 
			ena_reg_state_o = 1'b0; // désactive enregistrement dans le registre
			end

			da : begin 
			ena_cpt_o = 1'b1;
			end 

			end_da: begin 
	  		conf_xor_down_o = 2'b01;  //Configure XOR DOWN pour le xor de la fin de la phase "donnée associée"
			ena_xor_down_o = 1'b1; //Active XOR DOWN
			init_b_o = 1'b1; // Initialise le compteur à 6
			ena_cpt_o = 1'b1;
			end 

			xor_p1: begin 
			ena_cpt_o = 1'b1;
			ena_xor_up_o = 1'b1; //Active XOR UP pour la première étape de texte clair
	   		cipher_valid_o = 1'b1; // Indication si les données chiffrées sont valides
			end

			wait_p1: begin 
			ena_reg_state_o = 1'b0;
			end

			tc1 : begin 
			ena_cpt_o = 1'b1;
			end 

			end_tc1 : begin
			init_b_o = 1'b1; // Initialise le compteur à 6
			ena_cpt_o = 1'b1;
			end

			wait_p2: begin 
			ena_reg_state_o = 1'b0; //Desactive enregistremrent de l'etat
			end

			xor_p2: begin 
			ena_cpt_o = 1'b1;
			ena_xor_up_o = 1'b1; //Active XOR UP pour la deuxième étape de texte clair
	   		cipher_valid_o = 1'b1; // Indication si les données chiffrées sont valides
			end

			tc2 : begin 
			ena_cpt_o = 1'b1;
			end 

			end_tc2: begin 
			init_a_o = 1'b1; // Initialise le compteur à 0
			conf_xor_down_o = 2'b10; //Configure XOR DOWN 
			ena_xor_down_o = 1'b1; //Active XOR DOWN
			end 

			wait_p3: begin 
			ena_reg_state_o = 1'b0;
			end

			xor_p3: begin 
			cipher_valid_o = 1'b1; // Indication si les données chiffrées sont valides
			ena_xor_up_o = 1'b1; //Active XOR UP pour la troisième étape de texte clair
			end

			finalisation: begin 
			ena_cpt_o = 1'b1;
			end

			end_finalisation: begin 
			ena_cpt_o = 1'b1; 
			ena_xor_down_o = 1'b1; //Active XOR DOWN
			conf_xor_down_o = 2'b11; //Configure XOR DOWN
			end

			xor_final: begin 
			ena_cpt_o = 1'b1; 
			end_o = 1'b1; //Fin du processus de chiffrement
			end

			fin : begin
			end

		endcase
	end : OUTPUT_LOGIC

endmodule : fsm


