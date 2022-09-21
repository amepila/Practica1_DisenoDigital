/*----------------------------------------------------------------------------------------
** MODULE NAME: pkg_alu.sv
** DESCRIPTION: In this file is saved the common variables in the project
** VERSION:  	1.0
** AUTHORS:  	Ricardo Zamora, Andres Hernandez
** DATE:    	20 / 09 / 22
** -------------------------------------------------------------------------------------- */

`ifndef PKG_ALU_SV
    `define PKG_ALU_SV
	
package pkg_alu;

parameter DW_IN	 = 5;	// Data width of inputs
parameter DW_OUT = 8;	// Data width of outputs
parameter NO 	 = 4;	// Number bits to save operations
parameter NF 	 = 5;	// Number of output flags
parameter ND	 = 7;	// Number of leds in 7-segments
parameter DECDIG = 3;	// Number of decimal digits
parameter NS	 = 3;	// Number of display segments

typedef logic [DECDIG-1:0][ND-1:0] t_seg;	// Output display segments

typedef struct{
	logic	enableA;
	logic	enableB;
	logic	selector;
	logic	start;
	logic 	[DW_IN-1:0] numberA;
	logic 	[DW_IN-1:0] numberB;
	logic 	[NO-1:0] control;
	logic signed[DW_OUT-1:0] result;
	logic signed[DW_OUT-1:0] result_dis;
	logic	zero;
	logic	ready;
	logic	overflow;
	logic	carry;
	logic	negative;
	logic	ready_out;
} t_topwires;		// Structure with data types used in the ALU top

typedef enum logic [2:0]{
	WAIT_A,
	SAVE_A,
	WAIT_B,
	SAVE_B,
	CALCULATION
} states_t;			// Enum with states used in the ALU state machine 

typedef enum logic [2:0]{
	IDLE,
	SHIFT,
	SHIFT_IDX,
	ADD,
	DG_IDX,
	READY
} bcdstates_t;		// Enum with states used in the BCD state machine 

typedef struct{
	logic [DECDIG*4-1:0] bcd;
	logic [DW_OUT-1:0] bin;
	logic [DECDIG-1:0] dig_idx;
	logic [7:0] loop_count;
	logic [3:0] bcd_dig;
	logic ready;
	logic add;
	bcdstates_t state;
	logic [3:0] count;
} bcdreg_t;			// Structure data type with register/wires for BCD

typedef struct{
	logic [NS*4-1:0] bcd_seg;
	logic ready;
	t_seg pipo;
	logic [DW_OUT-1:0] bin;
} display_t;		// Structure data type for displays

endpackage
`endif