`timescale 1ns / 1ps
module constant_addition_tb import ascon_pack::*;
	(

	);

	type_state constant_input_s;
	type_state constant_output_s;
	logic[3:0] round_s;

	constant_addition DUT (
		.constant_add_i(constant_input_s),
		.constant_add_o(constant_output_s),
		.round_i(round_s)
	);

	initial begin
		constant_input_s[0] = 64'h80400c0600000000;
		constant_input_s[1] = 64'h8a55114d1cb6a9a2;
		constant_input_s[2] = 64'hbe263d4d7aecaaff;
		constant_input_s[3] = 64'h4ed0ec0b98c529b7;
		constant_input_s[4] = 64'hc8cddf37bcd0284a;
		round_s = 4'h0;
		#10;
		constant_input_s[0] = 64'ha71b22fa2d0f5150;
		constant_input_s[1] = 64'hb11e0a9a608e0016;
		constant_input_s[2] = 64'h076f27ad4d99d5e7;
		constant_input_s[3] = 64'ha72ac1ad8440b0b7;
		constant_input_s[4] = 64'h0657b0d6eaf9c1c4;
		round_s = 4'h1;
		#10;
		constant_input_s[0] = 64'h95bd2279b9a6ca67;
		constant_input_s[1] = 64'h98a6c708314c3ef7;
		constant_input_s[2] = 64'h50117c5d8e989bd6;
		constant_input_s[3] = 64'h5bfb95dcdede2f1e;
		constant_input_s[4] = 64'ha6aaffa224f4a42f;
		round_s = 4'h2;
		#10;
		constant_input_s[0] = 64'h162901ce5722b2fe;
		constant_input_s[1] = 64'h236c1fca1153d660;
		constant_input_s[2] = 64'heca11976718e1853;
		constant_input_s[3] = 64'ha305993b667e5222;
		constant_input_s[4] = 64'h467799e3e4a82e05;
		round_s = 4'h3;
		#10;
		constant_input_s[0] = 64'h77deb0974ab83049;
		constant_input_s[1] = 64'hc3a306f2f4f2a478;
		constant_input_s[2] = 64'h67b186a49c0d9bfb;
		constant_input_s[3] = 64'ha37fb6b86c37a156;
		constant_input_s[4] = 64'h049fe08ba4611958;
		round_s = 4'h4;
		#10;
		constant_input_s[0] = 64'h9bdd69cc4f812537;
		constant_input_s[1] = 64'haf4cae7efa39989a;
		constant_input_s[2] = 64'h71a61481b4bdb7c3;
		constant_input_s[3] = 64'h4e44a40a2119d619;
		constant_input_s[4] = 64'h83e0ee6e48d77536;
		round_s = 4'h5;
		#10;
		constant_input_s[0] = 64'haab43c56cb297f2f;
		constant_input_s[1] = 64'h62df33cce2ac6e73;
		constant_input_s[2] = 64'he66d5ceb1685fee5;
		constant_input_s[3] = 64'hf5b6146c8d0a4a84;
		constant_input_s[4] = 64'h1c7959693a7197d3;
		round_s = 4'h6;
		#10;
		constant_input_s[0] = 64'h473fd776ed5ae4a9;
		constant_input_s[1] = 64'h189bb0e06f0fd047;
		constant_input_s[2] = 64'ha34aa652c19298cf;
		constant_input_s[3] = 64'ha2e276921e68bedb;
		constant_input_s[4] = 64'he2540a9794e08a4d;
		round_s = 4'h7;
		#10;
		constant_input_s[0] = 64'hfc3e8ba2258173aa;
		constant_input_s[1] = 64'hcd0ed98f425027b5;
		constant_input_s[2] = 64'hd6377a699a5466d1;
		constant_input_s[3] = 64'h0e098c4844f54dfc;
		constant_input_s[4] = 64'h7050566fcd38acf2;
		round_s = 4'h8;
		#10;
		constant_input_s[0] = 64'h19dcbe122fe31912;
		constant_input_s[1] = 64'hb9b442138c57b67b;
		constant_input_s[2] = 64'hd88f511903315dea;
		constant_input_s[3] = 64'h90a65b7c59b47a3a;
		constant_input_s[4] = 64'h7be2af71150576c5;
		round_s = 4'h9;
		#10;
		constant_input_s[0] = 64'h91ca146dc8b303c3;
		constant_input_s[1] = 64'h4ae7596b911b8b4a;
		constant_input_s[2] = 64'h84907dad9f0678e0;
		constant_input_s[3] = 64'he002999d53672330;
		constant_input_s[4] = 64'hd2c56f3f9888bfb5;
		round_s = 4'hA;
		#10;
		constant_input_s[0] = 64'hba54e245d2716400;
		constant_input_s[1] = 64'h8b00ee0f752f8ad6;
		constant_input_s[2] = 64'h1a665562a83a728d;
		constant_input_s[3] = 64'h467c02c12687f65d;
		constant_input_s[4] = 64'h65f6cea99ae75349;
		round_s = 4'hB;
		#10;
	end
endmodule : constant_addition_tb


