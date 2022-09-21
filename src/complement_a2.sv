/*----------------------------------------------------------------------------------------
** MODULE NAME: complement_a2.sv
** DESCRIPTION: Convert the signed value to unsigned value
** INPUTS: 		i_val
** OUTPUTS:  	o_val
** AUTHORS:  	Ricardo Zamora, Andres Hernandez
** DATE:    	20 / 09 / 22
** -------------------------------------------------------------------------------------- */
`ifndef COMPLEMENT_A2_SV
    `define COMPLEMENT_A2_SV
module complement_a2
import pkg_alu::*;
(
	input signed [DW_OUT-1:0] i_val, 	// Input signed value

	output [DW_OUT-1:0] o_val			// Output unsigned value	
);

// Verify the MSB to convert the number to unsigned or stay in positive value
assign o_val   =  ( i_val[DW_OUT-1] ) ? ( (~i_val) + 1'b1 ) : i_val; 

endmodule
`endif