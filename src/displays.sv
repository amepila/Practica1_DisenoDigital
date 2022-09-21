/*----------------------------------------------------------------------------------------
** MODULE NAME: displays.sv
** DESCRIPTION: Instance module to convert the data to show in the 7-seg display
** INPUTS: 		clk, rst, i_start, i_bin
** OUTPUTS:  	o_seg
** AUTHORS:  	Ricardo Zamora, Andres Hernandez
** DATE:    	20 / 09 / 22
** -------------------------------------------------------------------------------------- */
`ifndef DISPLAYS_SV
    `define DISPLAYS_SV
module displays
import pkg_alu::*;
(
	input clk, rst,
	input i_start,				// Input to activate the displays when the result from alus is ready
	input [DW_OUT-1:0] i_bin,	// Signed binary input
	output t_seg o_seg			// Output with 7-seg format
);	

display_t w_display;
genvar i;

complement_a2 complement_a2
(
	// Inputs
	.i_val(i_bin),
	
	// Outputs
	.o_val(w_display.bin)
);

bin_to_bcd #(.DW_OUT(DW_OUT), .DECDIG(DECDIG)) binToBCD
(
	// Inputs
	.i_binary(w_display.bin),
	
	// Outputs
	.o_bcd(w_display.bcd_seg)
);

// For generate to instance the 7-segments with its pipo output register
generate 
	for(i = 0; i < NS; i = i+1)
		begin: bit_
			bin_7seg display (.i_bin(w_display.bcd_seg[(4*(i+1)-1):(4*i)]), 
								.o_seg(w_display.pipo[i]));
			
			pipo_u #(.DW(ND)) pipo_seg (.clk(clk), .rst(rst), .en(i_start),
			.i_data(w_display.pipo[i]), .o_data(o_seg[i]));
		end
	endgenerate
endmodule
`endif		
