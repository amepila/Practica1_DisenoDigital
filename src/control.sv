/*----------------------------------------------------------------------------------------
** MODULE NAME: control.sv
** DESCRIPTION: Basic State Machine to control the ALU operations, there are only one input	
				button to load the input values, and the outputs enable the registers
** INPUTS: 		clk, rst, i_load, i_ready	 
** OUTPUTS:  	o_enableA, o_enableB, o_selector, o_start, o_ready
** VERSION:  	1.0
** AUTHORS:  	Ricardo Zamora, Andres Hernandez
** DATE:    	20 / 09 / 22
** -------------------------------------------------------------------------------------- */
`ifndef CONTROL_SV
    `define CONTROL_SV
module control
import pkg_alu::*;
(
	// Inputs
	input clk, rst,
	input i_load1,				// Input load button to store the values
	input i_load2,				// Input load button to store the values
	input i_ready,				// Ready signal from ALU module
	
	// Outputs
	output reg o_enableA,		// Signal to enable the register for A
	output reg o_enableB,		// Signal to enable the register for B
	output reg o_selector,		// Signal to enable the register for selector
	output reg o_start,			// Signal to start the ALU
	output reg o_ready			// Ready signal to change of state
);

states_t r_state;				// Variable enum type to store the states

always_ff@(posedge clk, negedge rst) begin: state_machine
	if(!rst)
		r_state <= WAIT_A;					// Initial state after reset
	else begin
		case(r_state)
			WAIT_A: begin					// Waits A for button action
				if(!i_load1)				// If load button is pressed the state change
					r_state <= SAVE_A;
				else
					r_state <= WAIT_A;		// If not, stay waiting A
			end
			
			SAVE_A: begin					// Saves A value
				r_state <= WAIT_B;			// Continue with the following state
			end
			
			WAIT_B: begin
				if(!i_load2)				// Waits B for button action
					r_state <= SAVE_B;		// If load button is pressed the state change
				else
					r_state <= WAIT_B;		// If not, stay waiting B
			end
			
			SAVE_B: begin					// Saves B value
				r_state <= CALCULATION;		// Continue with the following state
			end
			
			CALCULATION: begin				// In this state, ALU performs the operations
				if(i_ready)					
					r_state <= WAIT_A;		// Result is ready continues to wait_a state
				else
					r_state <= CALCULATION;	// If not, stay in calculation state
			end
			
			default: begin
				r_state <= WAIT_A;			// Return to waitA in default case
			end
		endcase
	end
end: state_machine

always_comb begin: outputs
	case(r_state)
		WAIT_A: begin						// None signal is enabled
			o_enableA 	<= '0;
			o_enableB 	<= '0;
			o_selector 	<= '0;
			o_start 	<= '0;
			o_ready		<= '0;
		end
		
		SAVE_A: begin						// Enable the register of A
			o_enableA 	<= 1'b1;
			o_enableB 	<= '0;
			o_selector 	<= '0;
			o_start 	<= '0;
			o_ready		<= '0;
		end
		
		WAIT_B: begin						// Non signal is enabled
			o_enableA 	<= '0;
			o_enableB 	<= '0;
			o_selector 	<= '0;
			o_start 	<= '0;
			o_ready		<= '0;
		end
		
		SAVE_B: begin
			o_enableA 	<= '0;				// Enable the register of A and register of selector
			o_enableB 	<= 1'b1;
			o_selector 	<= 1'b1;
			o_start 	<= '0;
			o_ready		<= '0;
		end
		
		CALCULATION: begin					// Send the start signal to ALU
			o_enableA 	<= '0;	
			o_enableB 	<= '0;
			o_selector 	<= '0;
			o_start 	<= 1'b1;
			o_ready		<= 1'b1;
		end
		default: begin						// Default case all zeros
			o_enableA 	<= '0;
			o_enableB 	<= '0;
			o_selector 	<= '0;
			o_start 	<= '0;
			o_ready		<= '0;
		end
	endcase
end: outputs

endmodule
`endif