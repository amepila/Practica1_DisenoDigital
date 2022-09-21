/*----------------------------------------------------------------------------------------
** MODULE NAME: top_alu.sv
** DESCRIPTION: Top module of ALU, there are instances of modules
** INPUTS: 		clk, rst, i_load, i_control, i_data,  
** OUTPUTS:  	o_zero, o_ready, o_overflow, o_carry, o_negative, o result, o_display, o_segments
** VERSION:  	1.0
** AUTHORS:  	Ricardo Zamora, Andres Hernandez
** DATE:    	20 / 09 / 22
** -------------------------------------------------------------------------------------- */
`ifndef TOP_ALU_SV
    `define TOP_ALU_SV
module top_alu
import pkg_alu::*;
(
	// Inputs
	input clk, rst, load1, load2,		
	input [NO-1:0] i_control,		// Selector to chose the operation to perform
	input signed[DW_IN-1:0] i_num,	// Input numbers
	
	// Outputs
	output o_zero,					// Zero Flag
	output o_ready,					// Ready Flag
	output o_overflow,				// Overflow Flag
	output o_carry,					// Carry Flag
	output o_negative,				// Negative Flag
	output signed[DW_OUT-1:0] o_result,// ALU result
	output t_seg o_segments			// Display segments
);

t_topwires w_topwires;

pipo #(.DW(DW_IN)) PIPO_A
(
	// Inputs
	.clk(clk), .rst(rst), .en(w_topwires.enableA), .i_data(i_num),
	
	// Outputs
	.o_data(w_topwires.numberA)
);

pipo #(.DW(DW_IN)) PIPO_B
(
	// Inputs
	.clk(clk), .rst(rst), .en(w_topwires.enableB), .i_data(i_num),
	
	// Outputs
	.o_data(w_topwires.numberB)
);

pipo_u #(.DW(NO)) PIPO_CTRL
(
	// Inputs
	.clk(clk), .rst(rst), .en(w_topwires.selector), .i_data(i_control),
	
	// Outputs
	.o_data(w_topwires.control)
);

control	CONTROL
(
	// Inputs
	.clk(clk), .rst(rst), .i_load1(load1), .i_load2(load2), .i_ready(w_topwires.ready),
	
	// Outputs
	.o_enableA(w_topwires.enableA), .o_enableB(w_topwires.enableB), 
	.o_selector(w_topwires.selector), .o_start(w_topwires.start), 
	.o_ready(w_topwires.ready_out)
);

alu #(.DW_IN(DW_IN), .DW_OUT(DW_OUT), .NO(NO)) ALU
(
	// Inputs
	.i_numberA(w_topwires.numberA), .i_numberB(w_topwires.numberB), 
	.control(w_topwires.control), .enable(w_topwires.start),
	
	// Outputs
	.o_result(w_topwires.result), .o_zero(w_topwires.zero), .o_ready(w_topwires.ready), 
	.o_overflow(w_topwires.overflow), .o_carry(w_topwires.carry), .o_negative(w_topwires.negative)
);

pipo_u #(.DW(NF)) PIPO_FLAGS
(
	// Inputs
	.clk(clk), .rst(rst), .en(w_topwires.ready), 
	.i_data({w_topwires.zero,w_topwires.ready,w_topwires.overflow,w_topwires.carry,w_topwires.negative}),
	
	// Outputs
	.o_data({o_zero,o_ready,o_overflow,o_carry,o_negative})
);

pipo #(.DW(DW_OUT)) PIPO_OUT
(
	// Inputs
	.clk(clk), .rst(rst), .en(w_topwires.ready), .i_data(w_topwires.result),
	
	// Outputs
	.o_data(o_result)
);

displays DISPLAY
(
	// Inputs
	.clk(clk), .rst(rst), .i_start(w_topwires.ready), .i_bin(w_topwires.result),
	
	// Outputs
	.o_seg(o_segments)
);

endmodule
`endif