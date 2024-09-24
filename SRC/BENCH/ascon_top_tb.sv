`timescale 1ns/1ps

module ascon_top_tb import ascon_pack::*;
	(

	);


	logic clock_s;
	logic resetb_s;
	logic start_s;
	logic data_valid_s;
	logic[63:0] data_xor_up_s;
	logic[127:0] key_s;
	logic[127:0] nonce_s; 


	logic cipher_valid_s;
	logic[63:0] cipher_s;
	logic[127:0] tag_s;  	
	logic end_s;	


	ascon_top DUT (
		.clock_i_s(clock_s),
	 	.resetb_i_s(resetb_s),
		.start_i_s(start_s),
		.data_valid_i_s(data_valid_s),
		.data_xor_up_i_s(data_xor_up_s),
		.key_i_s(key_s),
		.nonce_i_s(nonce_s),  

		.cipher_valid_o_s(cipher_valid_s),
		.cipher_o_s(cipher_s),
		.tag_o_s(tag_s),  	
		.end_o_s(end_s)
	);


	// Génération de l'horloge
	initial begin 
		clock_s = 1'b0;
		forever #5 clock_s = ~clock_s;
	end 

	initial begin
		
		key_s = 128'h8A55114D1CB6A9A2BE263D4D7AECAAFF; //Affectation de la clé
		nonce_s = 128'h4ED0EC0B98C529B7C8CDDF37BCD0284A; //Affection du nonce		

		data_valid_s = 1'b0;
		start_s = 1'b0;
		resetb_s = 1'b0;
		
		data_xor_up_s = 64'h0;	
		#50;
		resetb_s = 1'b1; // Activation du système

		#10;
		//on lance le programme. Démarrage du chiffrement
		start_s = 1'b1;
		#10; 
		start_s = 1'b0;
		#120;

		//Etape du XOR avec A1 
		data_valid_s = 1'b1;
		//étape de padding
		data_xor_up_s = 64'h4120746F20428000;
		#10;
		data_valid_s = 1'b0;
		#120;

		//Etape du XOR avec P1 
		data_valid_s = 1'b1;
		data_xor_up_s = 64'h5244562061752054;	
		#10;
		data_valid_s = 1'b0;
		#120;

		//Etape du XOR avec P2
		data_valid_s = 1'b1;
		data_xor_up_s = 64'h6927626172206365;
		#10;
		data_valid_s = 1'b0;
		#120;

		//Etape du XOR avec P3 
		data_valid_s = 1'b1; 
		//étape de padding
		data_xor_up_s = 64'h20736F6972203F80;	
		#10;
		data_valid_s = 1'b0;
		#120;
		
		//Fin 
		data_valid_s = 1'b1;
		#10;
		data_valid_s = 1'b0;

		
	end
endmodule : ascon_top_tb

