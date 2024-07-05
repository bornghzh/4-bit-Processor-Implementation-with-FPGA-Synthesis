
module Register4Bit(
    input Clock,
    input Reset,
	 input Load,
    input [3:0] Data_in,
    output [3:0] Data_out
    );

	D_FlipFlop D0 (Clock&Load,Reset,Data_in[0],Data_out[0]);
	D_FlipFlop D1 (Clock&Load,Reset,Data_in[1],Data_out[1]);
	D_FlipFlop D2 (Clock&Load,Reset,Data_in[2],Data_out[2]);
	D_FlipFlop D3 (Clock&Load,Reset,Data_in[3],Data_out[3]);

endmodule
