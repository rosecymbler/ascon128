`timescale 1ns / 1ps
module permutation_xor_pour_fsm_tb import ascon_pack::*;
	(

	);

	logic clock_s;
	logic resetb_s;
	logic[3:0] round_s;
	logic input_select_s;
	type_state permutation_input_s;
	type_state permutation_output_s;
	type_state cipher_state_output_s;
	logic[63:0] data_xor_up_input_s;
	logic[255:0] data_xor_down_input_s;
	logic ena_xor_up_input_s;
	logic ena_xor_down_input_s;
	logic ena_reg_state_input_s;

	permutation_xor_pour_fsm DUT (
		.clock_i(clock_s),
		.resetb_i(resetb_s),
		.round_i(round_s),
		.input_select_i(input_select_s),
		.permutation_i(permutation_input_s),
		.permutation_o(permutation_output_s),
		.cipher_state_o(cipher_state_output_s),
		.data_xor_up_i(data_xor_up_input_s),
		.data_xor_down_i(data_xor_down_input_s),
		.ena_xor_up_i(ena_xor_up_input_s),
		.ena_xor_down_i(ena_xor_down_input_s),
		.ena_reg_state_i(ena_reg_state_input_s)
	);


	initial begin 
		clock_s = 1'b0;
		forever #5 clock_s = ~clock_s;
	end 

	initial begin
		resetb_s = 1'b0;
		input_select_s = 1'b1;
		permutation_input_s[0]= 64'h80400c0600000000;
		permutation_input_s[1]= 64'h8a55114d1cb6a9a2;
		permutation_input_s[2]= 64'hbe263d4d7aecaaff;
		permutation_input_s[3]= 64'h4ed0ec0b98c529b7;
		permutation_input_s[4]= 64'hc8cddf37bcd0284a;
		round_s = 4'h0;
		ena_xor_up_input_s = 1'b0;
		ena_xor_down_input_s = 1'b0;
		ena_reg_state_input_s = 1'b1;
		data_xor_up_input_s = 1'b0;
		data_xor_down_input_s = 1'b0;
		#10;
		resetb_s = 1'b1;
		#10;
		input_select_s = 1'b0;
		round_s = 4'h1;
		#10;
		round_s = 4'h2;
		#10;
		round_s = 4'h3;
		#10;
		round_s = 4'h4;
		#10;
		round_s = 4'h5;
		#10;
		round_s = 4'h6;
		#10;
		round_s = 4'h7;
		#10;
		round_s = 4'h8;
		#10;
		round_s = 4'h9;
		#10;
		round_s = 4'hA;
		#10;
		round_s = 4'hB;
		ena_xor_up_input_s = 1'b0;
		ena_xor_down_input_s = 1'b1;
		data_xor_down_input_s = 128'h8A55114D1CB6A9A2BE263D4D7AECAAFF; 
		#10;
		ena_reg_state_input_s = 1'b0;
		#10;
		
	end
endmodule : permutation_xor_pour_fsm_tb

