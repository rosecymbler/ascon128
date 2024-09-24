//                              -*- Mode: Verilog -*-
// Filename        : compteur_double_init.sv
// Description     : package definition
// Author          : Jean-Baptiste RIGAUD
// Created On      : Sat Oct 14 15:30:30 2023
// Last Modified By: Jean-Baptiste RIGAUD
// Last Modified On: Sat Oct 14 15:30:30 2023
// Update Count    : 0
// Status          : Unknown, Use with caution!
`timescale 1 ns/ 1 ps

module compteur_double_init import ascon_pack::*;
   (
    input logic 	clock_i,
    input logic 	resetb_i,
    input logic 	en_i,
    input logic 	init_a_i,
    input logic 	init_b_i,
    output logic [3 : 0] cpt_o      
    ) ;

   logic [3:0] cpt_s;
   
   always_ff @(posedge clock_i or negedge resetb_i)
     begin
	if (resetb_i == 1'b0) begin
	   cpt_s <= 0;
	end
	else begin 
	   if (en_i == 1'b1) 
	     begin
		if (init_a_i==1'b1) begin
		   cpt_s<=0; // Réinitialise le compteur à 0 si le signal init_a_i est actif
		end 
		else if (init_b_i==1'b1) begin
		   cpt_s<=6; // Initialise le compteur à 6 si le signal init_b_i est actif
		end 
		else cpt_s <= cpt_s+1; // Incrémente le compteur s'il n'y a pas de signal init_a_i ou init_b_i
                
	     end
	end
     end

   assign cpt_o = cpt_s;
   
endmodule: compteur_double_init


