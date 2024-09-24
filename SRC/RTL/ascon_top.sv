`timescale 1ns/1ps

module ascon_top import ascon_pack::*;
	(
	 	input logic clock_i_s,
	 	input logic resetb_i_s,
		input logic start_i_s,
		input logic data_valid_i_s,
		input logic[63:0] data_xor_up_i_s,
		input logic[127:0] key_i_s,
		input logic[127:0] nonce_i_s,  

		output logic cipher_valid_o_s,
		output logic[63:0] cipher_o_s,
		output logic[127:0] tag_o_s,  	
		output logic end_o_s	
	);

//déclaration
	logic[3:0] round_s;
	logic input_select_s;
	logic[255:0] data_xor_down_s;
	logic ena_reg_state_s;
	logic ena_xor_up_s;
	logic ena_xor_down_s;
	logic ena_round_s;
	logic init_a_s;
	logic init_b_s;
	logic[1:0] conf_xor_down_s;

	type_state permutation_i_s;
	type_state permutation_o_s;
	type_state cipher_state_o_s;

//définition
	assign permutation_i_s[0] = 64'h80400C0600000000;
	assign permutation_i_s[1] = key_i_s[127:64];
	assign permutation_i_s[2] = key_i_s[63:0];
	assign permutation_i_s[3] = nonce_i_s[127:64];
	assign permutation_i_s[4] = nonce_i_s[63:0];



	permutation_xor_pour_fsm permutation_xor_pour_fsm_inst
	(
		.clock_i(clock_i_s),
	 	.resetb_i(resetb_i_s),
		.round_i(round_s),
		.input_select_i(input_select_s),
		.permutation_i(permutation_i_s),
		.permutation_o(permutation_o_s),
		.data_xor_up_i(data_xor_up_i_s),
		.data_xor_down_i(data_xor_down_s),
		.ena_xor_up_i(ena_xor_up_s),
		.ena_xor_down_i(ena_xor_down_s),	
		.ena_reg_state_i(ena_reg_state_s),
		.cipher_state_o(cipher_state_o_s) 
	);

	compteur_double_init compteur_double_init_inst
	(
		.clock_i(clock_i_s),
    		.resetb_i(resetb_i_s),
    		.en_i(ena_reg_state_s),
    		.init_a_i(init_a_s),
    		.init_b_i(init_b_s),
    		.cpt_o(round_s)      
	);

	fsm fsm_inst
	(
		.clock_i(clock_i_s),
	 	.resetb_i(resetb_i_s),
		.round_i(round_s),
		.start_i(start_i_s),
		.data_valid_i(data_valid_i_s),
		.cipher_valid_o(cipher_valid_o_s),
		.end_o(end_o_s),
		.input_select_o(input_select_s),
		.ena_xor_up_o(ena_xor_up_s),
		.ena_xor_down_o(ena_xor_down_s),
		.ena_reg_state_o(ena_reg_state_s),
		.conf_xor_down_o(conf_xor_down_s),
		.init_a_o(init_a_s),
		.init_b_o(init_b_s),
		.ena_cpt_o(ena_round_s)      
	);



	always_comb begin : xor_down
		data_xor_down_s = 256'h0;
		case (conf_xor_down_s)
			2'b00 : data_xor_down_s = {128'h0, key_i_s};
			2'b01 : data_xor_down_s = 256'h1;
			2'b10 : data_xor_down_s = {key_i_s, 128'h0};
			2'b11 : data_xor_down_s = key_i_s;
	
		endcase
	end : xor_down


	// Instance de register_state pour le registre cipher
	register_cipher register_cipher_inst (
		.clock_i(clock_i_s),
		.resetb_i(resetb_i_s),
		.register_i(cipher_state_o_s[0]),
		.en_i(cipher_valid_o_s),
		.register_o(cipher_o_s)
	);

	// Instance de register_state pour le registre tag
	register_tag register_tag_inst (
		.clock_i(clock_i_s),
		.resetb_i(resetb_i_s),
		.register_i({permutation_o_s[3], permutation_o_s[4]}),
		.en_i(end_o_s),
		.register_o(tag_o_s)
	);


endmodule : ascon_top
