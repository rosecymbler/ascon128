`timescale  1ns/1ps

module register_state import ascon_pack::*;
	(
	 input logic	clock_i,
	 input logic	resetb_i,
	 input		type_state register_i,
	 input logic    en_i,
	 output		type_state register_o
	 );

	type_state register_s;

	// Register : gère l'état du registre avec clock et reset
	always @ (posedge clock_i, negedge resetb_i) begin
		if (resetb_i == 1'b0) begin 
			register_s <= {64'h0, 64'h0, 64'h0, 64'h0, 64'h0};
		end
		else begin
			if (en_i == 1'b1) // Si le signal à 1, mettre à jour le registre
				begin
				register_s <= register_i;
				end
			else register_s <= register_s; // Sinon, maintenir valeur actuelle
		end
			
		
	end

	assign register_o = register_s;

endmodule : register_state
