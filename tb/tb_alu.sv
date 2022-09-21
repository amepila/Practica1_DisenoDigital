/*----------------------------------------------------------------------------------------
** MODULE NAME: tb_alu.sv
** DESCRIPTION: Testbench of ALU, the operations are the following:
				CONTROL	| OPERATION								| TAG
				0000		SUM = A+B								SUM
				0001		REST = A-B								SUBS
				0010		~B = Arithmetich Negative of B			ANEGATIVE_B
				0011		MULT = A*B								MULTIPLICATION
				0100		A&B										AND
				0101		A|B										OR
				0110		~A										lNEGATIVE_A
				0111		A^B										XOR
				1000		A << B[3:0]								SHIFT_LEFT
				1001		A >> B[3:0]								SHIFT_RIGHT
** VERSION:  	1.0
** AUTHORS:  	Ricardo Zamora, Andres Hernandez
** DATE:    	20 / 09 / 22
** -------------------------------------------------------------------------------------- */

`timescale 1 ns/10 ps		// Time unit = 1ns, Resolution = 10ps
module tb_alu
	import pkg_alu::*; ();

	// Inputs
	reg	clk = 0;
	reg	rst;
	reg	load1;
	reg load2;
	reg	[NO-1:0] control;
	reg signed[DW_IN-1:0] num;
	
	// Outputs
	wire zero;
	wire ready;
	wire overflow;
	wire carry;
	wire negative;
	wire signed [DW_OUT-1:0] result;
	t_seg segments;
	
	// Unit Under Test 
	top_alu UUT
	(
		// Inputs
		.clk(clk), .rst(rst), .load1(load1), .load2(load2), .i_control(control), .i_num(num),
		
		// Outputs
		.o_zero(zero), .o_ready(ready), .o_overflow(overflow), .o_carry(carry),
		.o_negative(negative), .o_result(result), .o_segments(segments)
	);
	
	always #1 clk <= ~clk;	// Clock is always changing every time unit (ns)
	
	initial begin
		rst = 0;			// Inputs signals are zero in the initial time
		load1 = 1;			// Reset is active low, so the entire system is cleared
		load2 = 1;
		control = '0;		// Selector to sum operation
		num = 0;
		#2;					// Wait 2 time units (ns)
		rst = 1;			// Reset is desactivated
		
		num = 4; #2;		// A value is loaded
		load1 = 0; #4;		// Load button is pressed
		load1 = 1; #2;
		num = 15; #2;		// B value is loaded
		load2 = 0; #4;		// Load button is pressed
		load2 = 1; #2;
		
		control = 1;		// Selector for substraction operation
		num = 10; #2;		// A value is loaded 
		load1 = 0; #4;		// Load button is pressed
		load1 = 1; #2;		
		num = 10; #2;		// B value is loaded
		load2 = 0; #4;		// Load button is pressed
		load2 = 1; #2;
		
		control = 2;		// Selector for arithmetic negative operation
		num = -4; #2;		// A value is loaded
		load1 = 0; #4;		// Load button is pressed
		load1 = 1; #2;
		num = -12; #2;		// B value is loaded
		load2 = 0; #4;		// Load button is pressed
		load2 = 1; #2;
		
		control = 3;		// Selector for multiplication operation
		num = 2; #2;		// A value is loaded
		load1 = 0; #4;		// Load button is pressed
		load1 = 1; #2;		
		num = -8; #2;		// B value is loaded
		load2 = 0; #4;		// Load button is pressed
		load2 = 1; #2;
		
		control = 4;		// Selector for AND operation
		num = 12; #2;		// A value is loaded
		load1 = 0; #4;		// Load button is pressed
		load1 = 1; #2;		
		num = -11; #2;		// B value is loaded
		load2 = 0; #4;		// Load button is pressed
		load2 = 1; #2;		
		
		control = 5;		// Selector for OR operation
		num = 3; #2;		// A value is loaded
		load1 = 0; #4;		// Load button is pressed
		load1 = 1; #2;
		num = -12; #2;		// B value is loaded
		load2 = 0; #4;		// Load button is pressed
		load2 = 1; #2;		
		
		control = 6;		// Selector for logic negative operation
		num = 7; #2;		// A value is loaded
		load1 = 0; #4;		// Load button is pressed
		load1 = 1; #2;		
		num = 1; #2;		// B value is loaded
		load2 = 0; #4;		// Load button is pressed
		load2 = 1; #2;
		
		control = 7;		// Selector for XOR operation
		num = 10; #2;		// A value is loaded
		load1 = 0; #4;		// Load button is pressed
		load1 = 1; #2;		
		num = -6; #2;		// B value is loaded
		load2 = 0; #4;		// Load button is pressed
		load2 = 1; #2;
		
		control = 8;		// Selector for shift left operation
		num = -2; #2;		// A value is loaded
		load1 = 0; #4;		// Load button is pressed
		load1 = 1; #2;
		num = -14; #2;		// B value is loaded
		load2 = 0; #4;		// Load button is pressed
		load2 = 1; #2;
		
		control = 9;		// Selector for shift right operation
		num = 15; #2;		// A value is loaded
		load1 = 0; #4;		// Load button is pressed
		load1 = 1; #2;
		num = -13; #2;		// B value is pressed
		load2 = 0; #4;		// Load button is pressed
		load2 = 1; #12;
		
		control = '0;		// Clear the inputs
		num = 0;
		rst = 0; #2;		// Activates the reset for 2 time units (ns)
		rst = 1;
		
	end
	
endmodule