`timescale 1ns / 1ps 

module diffusion_layer_tb import ascon_pack::*;
	(

	);

	type_state diffusion_input_s;
	type_state diffusion_output_s;

	diffusion_layer DUT (
		.diffusion_i(diffusion_input_s),
		.diffusion_o(diffusion_output_s)
	);

	initial begin
		diffusion_input_s[0] = 64'h78e2cc41faabaa1a;
		diffusion_input_s[1] = 64'hbc7a2e775aababf7;
		diffusion_input_s[2] = 64'h4b81c0cbbdb5fc1a;
		diffusion_input_s[3] = 64'hb22e133e424f0250;
		diffusion_input_s[4] = 64'h044d33702433805d;
		#10;
	end
endmodule : diffusion_layer_tb
