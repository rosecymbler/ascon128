`timescale  1ns/1ps

module register_cipher import ascon_pack::*;
	(
	 input logic	clock_i,
	 input logic	resetb_i,
	 input logic[63:0] register_i,
	 input logic    en_i,
	 output logic[63:0] register_o
	 );

	logic[63:0] cipher_o_s;

	// Register : gère l'état du registre avec clock et reset
	always @ (posedge clock_i, negedge resetb_i) begin
		if (resetb_i == 1'b0) begin 
			cipher_o_s <= 64'h0;
		end
		else begin
			if (en_i == 1'b1) begin // Si le signal à 1, mettre à jour le registre
				cipher_o_s <= register_i;
			end
			else cipher_o_s <= cipher_o_s; // Sinon, maintenir valeur actuelle
		end	
		
	end

	assign register_o = cipher_o_s;

endmodule : register_cipher
