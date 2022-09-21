/*----------------------------------------------------------------------------------------
** MODULE NAME: pipo_u.sv
** DESCRIPTION: PIPO register to store unsigned values
** INPUTS: 		clk, rst, en, i_data,  
** OUTPUTS:  	o_data
** VERSION:  	1.0
** AUTHORS:  	Ricardo Zamora, Andres Hernandez
** DATE:    	20 / 09 / 22
** -------------------------------------------------------------------------------------- */
`ifndef PIPO_U_SV
    `define PIPO_U_SV
module pipo_u
#(parameter DW = 5)
(
	input clk, rst, en,
	input [DW-1:0] i_data,			// Input Bus Data with parametric value
	output reg [DW-1:0]  o_data		// Registered Output Data with parametric value
);

always_ff@(posedge clk, negedge rst) begin: pipou_register
	if(!rst)
		o_data <= '0;				// Reset event clear the output to zero
	else if(en)
		o_data <= i_data;			// Enable event saves the input data
	else
		o_data <= o_data;			// Default case
end: pipou_register

endmodule
`endif	