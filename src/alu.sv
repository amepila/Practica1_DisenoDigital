/*----------------------------------------------------------------------------------------
** MODULE NAME: alu.sv
** DESCRIPTION: ALU module with the following operations:
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
** INPUTS: 		i_numberA, i_numberB, control, enable  
** OUTPUTS:  	o_result, o_zero, o_ready, o_overflow, o_carry, o_negative
** VERSION:  	1.0
** AUTHORS:  	Ricardo Zamora, Andres Hernandez
** DATE:    	20 / 09 / 22
** -------------------------------------------------------------------------------------- */
`ifndef ALU_SV
	`define ALU_SV
module alu
import pkg_alu::*;
#(
	parameter DW_IN   = 5,						// Data width of inputs
	parameter DW_OUT  = 8,						// Data width of outputs
	parameter NO = 4,							// Number bits to save operations
	parameter MAXH 	  = (2**(DW_OUT-1))-1,		// Max value for positive multiplication output
	parameter MAXL    = -(2**(DW_OUT-1))		// Max value for negative multiplication output
)
(
	// Input signals (data and control signals)
	input signed [DW_IN-1:0] i_numberA, i_numberB,	// Input signed numbers					
	input [NO-1:0] control,							// Operation selector
	input enable,									// Enable signal to perform the ALU
	
	// Output result
	output reg signed [DW_OUT-1:0] o_result,		// ALU result with exception of multiplication
	
	// Output  flags
	output reg o_zero,								// Indicates the presence of zero result
	output reg o_ready,								// Indicates the finish of calculation
	output reg o_overflow,							// Indicates overflow in multiplication
	output reg o_carry,								// Indicates carry
	output reg o_negative							// Negative 
);
 
always_comb begin: alu
	if(enable) begin	// Signal from Start Button
		case(control)	// Operation selector
			0: begin
				// Data Outputs
				o_result 	= i_numberA + i_numberB;				    // Signed Sum
				
				// Flag Outputs
				o_zero 		= (o_result == '0) ? 1'b1: '0; 				// Detects if the result is zero
				o_ready 	= 1'b1;										// Sends the ready signal
				o_overflow 	= '0;										// There is no overflow in this op
				o_carry 	= '0;										// There is no carry in this op
				o_negative 	= (o_result[DW_OUT-1] == '0) ? '0: 1'b1;	// Detects if the result is negative
			end
			
			1: begin
				// Data Outputs
				o_result 		= i_numberA - i_numberB;				// Signed Substraction
				
				// Flag Outputs
				o_zero 		= (o_result == '0) ? 1'b1: '0;				// Detects if the result is zero
				o_ready 	= 1'b1;										// Sends the ready signal
				o_overflow 	= '0;										// There is no overflow in this op
				o_carry 	= '0;										// There is no carry in this op
				o_negative 	= (o_result[DW_OUT-1] == '0) ? '0: 1'b1;	// Detects if the result is negative			
				
			end
			
			2: begin
				// Data Outputs
				o_result 		= (i_numberB^{DW_IN{1'b1}}) + 1'b1;		// Arithmetic negative
				
				// Flag Outputs
				o_zero 		= (o_result == '0) ? 1'b1: '0; 				// Detects if the result is zero
				o_ready 	= 1'b1;										// Sends the ready signal
				o_overflow 	= '0;										// There is no overflow in this op
				o_carry 	= '0;										// There is no carry in this op
				o_negative 	= (o_result[DW_OUT-1] == '0) ? '0: 1'b1;	// Detects if the result is negative
			end
			
			3: begin
				// Data Outputs
				o_result 	= i_numberA * i_numberB;				    // Signed multiplication
				
				// Flag Outputs
				o_zero 		= (o_result == '0) ? 1'b1: '0;				// Detects if the result is zero
				o_ready 	= 1'b1;										// Sends the ready signal
				o_overflow 	= ((o_result > MAXH) || (o_result < MAXL)) ? 1'b1: '0;
				o_carry 	= '0;										// There is no carry in this op
				o_negative 	= (o_result[DW_OUT-1] == '0) ? '0: 1'b1;	// Detects if the result is negative
			end
			
			4: begin
				// Data Outputs
				o_result 		= i_numberA & i_numberB;				// Logical AND operation
				
				// Flag Outputs
				o_zero 		= (o_result == '0) ? 1'b1: '0; 				// Detects if the result is zero
				o_ready 	= 1'b1;										// Sends the ready signal
				o_overflow 	= '0;										// There is no overflow in this op
				o_carry 	= '0;										// There is no carry in this op
				o_negative 	= (o_result[DW_OUT-1] == '0) ? '0: 1'b1;	// Detects if the result is negative
			end
			
			5: begin
				// Data Outputs
				o_result 		= i_numberA | i_numberB;				// Logical OR operation
					
				// Flag Outputs
				o_zero 		= (o_result == '0) ? 1'b1: '0; 				// Detects if the result is zero
				o_ready 	= 1'b1;										// Sends the ready signal
				o_overflow 	= '0;										// There is no overflow in this op
				o_carry 	= '0;										// There is no carry in this op
				o_negative 	= (o_result[DW_OUT-1] == '0) ? '0: 1'b1;	// Detects if the result is negative
			end
			
			6: begin
				// Data Outputs
				o_result 		= ~i_numberA;							// Logical NOT operation

				// Flags Outputs
				o_zero 		= (o_result == '0) ? 1'b1: '0; 				// Detects if the result is zero
				o_ready 	= 1'b1;										// Sends the ready signal
				o_overflow 	= '0;										// There is no overflow in this op
				o_carry 	= '0;										// There is no carry in this op
				o_negative 	= (o_result[DW_OUT-1] == '0) ? '0: 1'b1;	// Detects if the result is negative
			end
			
			7: begin
				// Data Outputs
				o_result 		= i_numberA ^ i_numberB;				// Logical XOR operation
				
				// Flags Outputs
				o_zero 		= (o_result == '0) ? 1'b1: '0; 				// Detects if the result is zero
				o_ready 	= 1'b1;										// Sends the ready signal
				o_overflow 	= '0;										// There is no overflow in this op
				o_carry 	= '0;										// There is no carry in this op
				o_negative 	= (o_result[DW_OUT-1] == '0) ? '0: 1'b1;	// Detects if the result is negative
			end
			
			8: begin
				// Data Outputs
				o_result 		= i_numberA<<(i_numberB[3:0]);	// Shift left operation	
				
				// Flag Outputs
				o_zero 		= (o_result == '0) ? 1'b1: '0; 				// Detects if the result is zero
				o_ready 	= 1'b1;										// Sends the ready signal
				o_overflow 	= '0;										// There is no overflow in this op
				o_carry 	= '0;										// There is no carry in this op
				o_negative 	= (o_result[DW_OUT-1] == '0) ? '0: 1'b1;	// Detects if the result is negative
			end
			
			9: begin
				// Data Outputs
				o_result 		= i_numberA>>(i_numberB[3:0]);	// Shift right operation
				
				// Flag Outputs
				o_zero 		= (o_result == '0) ? 1'b1: '0; 				// Detects if the result is zero
				o_ready 	= 1'b1;										// Sends the ready signal
				o_overflow 	= '0;										// There is no overflow in this op
				o_carry 	= '0;										// There is no carry in this op
				o_negative 	= (o_result[DW_OUT-1] == '0) ? '0: 1'b1;	// Detects if the result is negative
			end
			
			default: begin
				// Data Output values for default case, all in zeros
				o_result 		= '0;									
				
				// Flag Output values for default case, all in zeros
				o_zero		= '0;
				o_ready		= '0;
				o_overflow	= '0;
				o_carry		= '0;
				o_negative	= '0;
			end
		endcase
	end
	else begin
		// Data Output values if start button is not pressed
		o_result 		= '0;
				
		// Flag Output values if start button is not pressed
		o_zero 			= '0; 
		o_ready 		= '0;
		o_overflow 		= '0;
		o_carry 		= '0;
		o_negative 		= '0;
	end
end: alu

endmodule
`endif