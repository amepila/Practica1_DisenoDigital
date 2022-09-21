/*----------------------------------------------------------------------------------------
** MODULE NAME: bin_to_bcd.sv
** DESCRIPTION: Use the double dabble algorithm, where shift and adds 3 if any value of
				columns (CENTS, DECS, UN) is greater than 4. It is ready when eight 
				shifts are performed
** INPUTS: 		i_binary
** OUTPUTS:  	o_bcd
** AUTHORS:  	Ricardo Zamora, Andres Hernandez
** DATE:    	20 / 09 / 22
** -------------------------------------------------------------------------------------- */
`ifndef BIN_TO_BCD_SV
    `define BIN_TO_BCD_SV
module bin_to_bcd
import pkg_alu::*;
#(
	parameter DW_OUT = 8,
	parameter DECDIG = 3
)
(
	input [DW_OUT-1:0] i_binary,	// Unsigned input
	
	output [DECDIG*4-1:0] o_bcd		// Output with the length of quantity of 7-seg used
);

bcdreg_t 	wires;

always@(i_binary) begin: bcd
	wires.bcd = 0;	// Loop is used to count the shift action
	for(wires.count = 0; wires.count < DW_OUT; wires.count = wires.count + 1) begin	
		wires.bcd = {wires.bcd[10:0],i_binary[(DW_OUT-1)-wires.count]};		// Output is shift left through concatenation
																			
		if((wires.count < 7) && (wires.bcd[3:0] > 4))						// Compares the units column if they reach 4
			wires.bcd[3:0] = wires.bcd[3:0] + 3;							// If the column reach 4, then add 4
		if((wires.count < 7) && (wires.bcd[7:4] > 4))						// Compares the decs columns if they reach 4
			wires.bcd[7:4] = wires.bcd[7:4] + 3;							// If the column reach 4, then add 4
		if((wires.count < 7) && (wires.bcd[11:8] > 4))						// Compares the cents columns if they reach 4
			wires.bcd[11:8] = wires.bcd[11:8] + 3;							// If the column reach 4, then add 4
	end

end: bcd

assign o_bcd = wires.bcd;													

endmodule
`endif