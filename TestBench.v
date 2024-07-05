`timescale 1ns / 1ps


module TestBench;

	// Inputs
	reg Clock;
	reg Reset;
	reg [7:0] Sw;
	reg Button0;
	reg Button1;
	reg Button5;

	// Outputs
	wire [7:0] Result_LCD;
	wire [7:0] Result_7Sg;

	// Instantiate the Unit Under Test (UUT)
	CPU MyCPU (
		.Clock(Clock), 
		.Reset(Reset), 
		.Sw(Sw), 
		.Button0(Button0), 
		.Button1(Button1), 
		.Button5(Button5), 
		.Result_LCD(Result_LCD), 
		.Result_7Sg(Result_7Sg)
	);

	initial begin
		Clock = 0;
		Reset = 0;
		Sw = 0;
		Button0 = 0;
		Button1 = 0;
		Button5 = 0;
		#10;
      Reset = 1;
		Button5 = 1;
		#10;
		
		//Note , Result Mean : Register 3 (+ Register 4 in MUL)
		
		
		Sw=8'b0000_0001; #10; Button0 = 1; #10; Button0 = 0; //Add
		Sw=8'b0111_0001; #10; Button0 = 1; #10; Button0 = 0; //7
		Sw=8'b0010_0001; #10; Button0 = 1; #10; Button0 = 0; //2
		Sw=8'b0; #10; Button0 = 1; #10; Button0 = 0; //Result 9

		#10;

		Sw=8'b0000_0011; #10; Button0 = 1; #10; Button0 = 0; //Sub
		Sw=8'b1110_0011; #10; Button0 = 1; #10; Button0 = 0; //14
		Sw=8'b1000_0011; #10; Button0 = 1; #10; Button0 = 0; //8
		Sw=8'b0; #10; Button0 = 1; #10; Button0 = 0; //Result 6

		#10;

		Sw=8'b0000_0111; #10; Button0 = 1; #10; Button0 = 0; //MUL
		Sw=8'b0010_0111; #10; Button0 = 1; #10; Button0 = 0; //2
		Sw=8'b0111_0111; #10; Button0 = 1; #10; Button0 = 0; //7
		Sw=8'b0; #10; Button0 = 1; #10; Button0 = 0; //Result 14

		#10;


		Sw=8'b0000_1111; #10; Button0 = 1; #10; Button0 = 0; //ST
		Sw=8'b0101_1111; #10; Button0 = 1; #10; Button0 = 0; //5
		Sw=8'b1010_1111; #10; Button0 = 1; #10; Button0 = 0; //10
		Sw=8'b0; #10; Button0 = 1; #10; Button0 = 0; //Result : Register5 = 10

		#10;


		Sw=8'b0000_1110; #10; Button0 = 1; #10; Button0 = 0; //LD
		Sw=8'b0101_1110; #10; Button0 = 1; #10; Button0 = 0; //5
		Sw=8'b0101_1110; #10; Button0 = 1; #10; Button0 = 0; //DontCare
		Sw=8'b0; #10; Button0 = 1; #10; Button0 = 0; //Result : Register 5

		#10;


		//Sw=8'b0000_1100; Button0 = 1; #10; Button0 = 0;
		
		Sw=8'b0000_1000; #10; Button0 = 1; #10; Button0 = 0; //NAND
		Sw=8'b0110_1000; #10; Button0 = 1; #10; Button0 = 0; //0110
		Sw=8'b1111_1000; #10; Button0 = 1; #10; Button0 = 0; //1111
		Sw=8'b0; #10; Button0 = 1; #10; Button0 = 0; //Result : 1001 = 9

		#10;

		Sw=8'b0000_1001; #10; Button0 = 1; #10; Button0 = 0; //NOR
		Sw=8'b0100_1001; #10; Button0 = 1; #10; Button0 = 0; //0100
		Sw=8'b1100_1001; #10; Button0 = 1; #10; Button0 = 0; //1100
		Sw=8'b0; #10; Button0 = 1; #10; Button0 = 0; //Result : 0011 = 3

		#10;
		Button1 = 1;
		Sw=8'b0000_1011; #10; Button0 = 1; #10; Button0 = 0; //XOR
		Sw=8'b1001_1011; #10; Button0 = 1; #10; Button0 = 0; //1001
		Sw=8'b1101_1011; #10; Button0 = 1; #10; Button0 = 0; //1101
		Sw=8'b0; #10; Button0 = 1; #10; Button0 = 0; //Result : 0100 = 4

	end
    
	always #5 Clock=~Clock;
	
endmodule

