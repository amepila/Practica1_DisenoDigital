/*----------------------------------------------------------------------------------------
** MODULE NAME: pipo.sv
** DESCRIPTION: PIPO register to store signed values
** INPUTS: 		clk, rst, en, i_data,  
** OUTPUTS:  	o_data
** VERSION:  	1.0
** AUTHORS:  	Ricardo Zamora, Andres Hernandez
** DATE:    	20 / 09 / 22
** -------------------------------------------------------------------------------------- */
`ifndef PIPO_SV
    `define PIPO_SV
module pipo
#(parameter DW = 5)
(
	input clk, rst, en,
	input signed [DW-1:0] i_data,			// Input Bus Data with parametric value
	output reg signed [DW-1:0] o_data		// Registered Output Data with parametric value
);

always_ff@(posedge clk, negedge rst) begin: pipo_register
	if(!rst)
		o_data <= '0;				// Reset event clear the output to zero
	else if(en)
		o_data <= i_data;			// Enable event saves the input data
	else
		o_data <= o_data;			// Default case
end: pipo_register

endmodule
`endif	