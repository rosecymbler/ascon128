`timescale 1ns / 1ps 
module constant_addition import ascon_pack::*;
	(
		input type_state constant_add_i,
		input logic [3:0] round_i,   //numéro de la ronde
		output type_state constant_add_o
	);

	assign  constant_add_o[0] = constant_add_i[0];
	assign  constant_add_o[1] = constant_add_i[1];	
	
	
	assign constant_add_o[2][63:8] = constant_add_i[2][63:8];
	//application de l'opération XOR sur les 8 derniers bits de x2
	assign constant_add_o[2][7:0] = constant_add_i[2][7:0] ^ round_constant[round_i];
	

	assign  constant_add_o[3] = constant_add_i[3];
	assign  constant_add_o[4] = constant_add_i[4];		
	
endmodule : constant_addition
