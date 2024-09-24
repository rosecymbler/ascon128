`timescale  1ns/1ps

module register_tag import ascon_pack::*;
	(
	 input logic	clock_i,
	 input logic	resetb_i,
	 input logic[127:0] register_i,
	 input logic    en_i,
	 output logic[127:0] register_o
	 );

	logic[127:0] tag_o_s;

	// Register : gère l'état du registre avec clock et reset
	always @ (posedge clock_i, negedge resetb_i) begin
		if (resetb_i == 1'b0) begin 
			tag_o_s <= 128'h0;
		end
		else begin
			if (en_i == 1'b1) begin // Si le signal à 1, mettre à jour le registre
				tag_o_s <= register_i;
			end
			else tag_o_s <= tag_o_s; // Sinon, maintenir valeur actuelle
		end	
		
	end

	assign register_o = tag_o_s;

endmodule : register_tag
