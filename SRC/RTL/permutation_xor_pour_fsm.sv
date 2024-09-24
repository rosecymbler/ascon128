`timescale 1ns/1ps

module permutation_xor_pour_fsm import ascon_pack::*;
	(
	 	input logic clock_i,
	 	input logic resetb_i,
		input logic[3:0] round_i,
		input logic input_select_i,
		input type_state permutation_i,
		output type_state permutation_o,
		output type_state cipher_state_o, // État intermédiaire après XOR, utilisé pour le chiffrement
		input logic[63:0] data_xor_up_i,
		input logic[255:0] data_xor_down_i,
		input logic ena_xor_up_i,
		input logic ena_xor_down_i,	
		input logic ena_reg_state_i	
	);

//declaration
	type_state const_add_to_subs_s;
	type_state register_output_s;
	type_state mux_to_xor_up_s;
	type_state subs_to_diff_s;
	type_state diff_to_xor_down_s;
	type_state xor_down_to_register_s;
	logic[63:0] xor_up_output_s;
	logic[255:0] xor_down_output_s;

//définition

//Si input_select_i vaut 1, alors le multiplexeur prend comme entrée permutation_i, sinon il prend register_output_s
	assign mux_to_xor_up_s = (input_select_i) ? permutation_i : register_output_s;


// On "instancie" l'opération XOR UP
	xor_up xor_up_inst
	(
		.data_xor_up_i(data_xor_up_i),
		.ena_xor_up_i(ena_xor_up_i),
		.state_i(mux_to_xor_up_s),
		.state_o(cipher_state_o)
	);
	
// On "instancie" l'addition de constante
	constant_addition constant_addition_inst
	(
		.constant_add_i(cipher_state_o),
		.round_i(round_i),	
		.constant_add_o(const_add_to_subs_s)
	);


// On "instancie" la couche de substitution
	substitution_layer substitution_layer_inst
	(
		.sub_layer_i(const_add_to_subs_s),
		.sub_layer_o(subs_to_diff_s)	
	);


// On "instancie" la couche de diffusion
	diffusion_layer diffusion_layer_inst
	(
		.diffusion_i(subs_to_diff_s),
		.diffusion_o(diff_to_xor_down_s)
	);

// On "instancie" l'opération XOR DOWN
	xor_down xor_down_inst
	(
		.data_xor_down_i(data_xor_down_i),
		.ena_xor_down_i(ena_xor_down_i),
		.state_i(diff_to_xor_down_s),
		.state_o(xor_down_to_register_s)
	);

// On "instancie" le registre pour enregistrer l'état 
	register_state register_state_inst
	(
		.clock_i(clock_i),
		.resetb_i(resetb_i),
		.register_i(xor_down_to_register_s),
		.en_i(ena_reg_state_i),
		.register_o(register_output_s)
	);
	
	
	assign permutation_o = register_output_s;

endmodule : permutation_xor_pour_fsm
