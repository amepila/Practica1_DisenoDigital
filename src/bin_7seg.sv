/*----------------------------------------------------------------------------------------
** MODULE NAME: bin_7seg.sv
** DESCRIPTION: Decoder from decimal value to 7-segments display
** INPUTS: 		i_bin
** OUTPUTS:  	o_seg
** AUTHORS:  	Ricardo Zamora, Andres Hernandez
** DATE:    	20 / 09 / 22
** -------------------------------------------------------------------------------------- */
`ifndef BIN_7SEG_SV
    `define BIN_7SEG_SV
module bin_7seg
import pkg_alu::*;
(
	input [3:0] i_bin,			// Input value of 4-bit extension
	output [6:0] o_seg			// Output value corresponding to 7-segments
);

reg [6:0] w_seg;

always_comb begin: segments		// Each assignation is translated to 7-segments from 0 to 9
	case (i_bin) 
		0: w_seg <= 7'b1000000;
		1: w_seg <= 7'b1111001;
		2: w_seg <= 7'b0100100;
		3: w_seg <= 7'b0110000;
		4: w_seg <= 7'b0011001;
		5: w_seg <= 7'b0010010;
		6: w_seg <= 7'b0000010;
		7: w_seg <= 7'b1111000;
		8: w_seg <= 7'b0000000;
		9: w_seg <= 7'b0010000;
		default: w_seg <= 7'b1111111;
	endcase
end: segments

assign o_seg = w_seg;			// Output value is assigned to the output

endmodule
`endif