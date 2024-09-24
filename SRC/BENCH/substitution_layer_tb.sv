`timescale 1ns / 1ps 

module substitution_layer_tb import ascon_pack::*;
	(

	);

	type_state sub_layer_input_s;
	type_state sub_layer_output_s;

	substitution_layer DUT (
		.sub_layer_i(sub_layer_input_s),
		.sub_layer_o(sub_layer_output_s)
	);

	initial begin
		sub_layer_input_s[0] = 64'h80400c0600000000;
		sub_layer_input_s[1] = 64'h8a55114d1cb6a9a2;
		sub_layer_input_s[2] = 64'hbe263d4d7aecaa0f;
		sub_layer_input_s[3] = 64'h4ed0ec0b98c529b7;
		sub_layer_input_s[4] = 64'hc8cddf37bcd0284a;
		#10;
	end
endmodule : substitution_layer_tb
