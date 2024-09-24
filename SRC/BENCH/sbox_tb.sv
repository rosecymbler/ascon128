`timescale 1ns / 1ps 

module sbox_tb import ascon_pack::*;
	(

	);

	logic[4:0] sbox_input_s;
	logic[4:0] sbox_output_s;

	sbox DUT (
		.sbox_i(sbox_input_s),
		.sbox_o(sbox_output_s)
	);

	initial begin
		sbox_input_s = 5'h00;
		#10;
		sbox_input_s = 5'h01;
		#10;
		sbox_input_s = 5'h02;
		#10;
		sbox_input_s = 5'h03;
		#10;
		sbox_input_s = 5'h04;
		#10;
		sbox_input_s = 5'h05;
		#10;
		sbox_input_s = 5'h06;
		#10;
		sbox_input_s = 5'h07;
		#10;
		sbox_input_s = 5'h08;
		#10;
		sbox_input_s = 5'h09;
		#10;
		sbox_input_s = 5'h0A;
		#10;
		sbox_input_s = 5'h0B;
		#10;
	end
endmodule : sbox_tb
