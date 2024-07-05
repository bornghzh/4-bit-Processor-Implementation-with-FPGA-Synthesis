
module CPU(
    input Clock,
    input Reset,
    input [7:0] Sw,
    input Button0,
    input Button1,
    input Button5,
    output [7:0] Result_LCD,
    output [7:0] Result_7Sg
    );

	reg [1:0] T;
	wire [3:0] Data_Reg,O_Mux0,O_Mux1,O_Mux2,O_Mux3,O_Mux4,F3,F4;
	wire [3:0] R [7:0];
	reg SMux;
	reg [7:0] Load_R;
	wire C,V;
	
	
	Mux2_1 Mx0 (Sw[3:0],Data_Reg,SMux,O_Mux0);
	Mux2_1 Mx1 (Sw[7:4],Data_Reg,SMux,O_Mux1);
	Mux2_1 Mx2 (Sw[7:4],Data_Reg,SMux,O_Mux2);
	Mux2_1 Mx3 (F3,Data_Reg,SMux,O_Mux3);
	Mux2_1 Mx4 (F4,Data_Reg,SMux,O_Mux4);

	Register4Bit R_0 (Clock,Button5,Load_R[0],O_Mux0,R[0]);
	Register4Bit R_1 (Clock,Button5,Load_R[1],O_Mux1,R[1]);
	Register4Bit R_2 (Clock,Button5,Load_R[2],O_Mux2,R[2]);
	Register4Bit R_3 (Clock,Button5,Load_R[3],O_Mux3,R[3]);
	Register4Bit R_4 (Clock,Button5,Load_R[4],O_Mux4,R[4]);
	Register4Bit R_5 (Clock,Button5,Load_R[5],Data_Reg,R[5]);
	Register4Bit R_6 (Clock,Button5,Load_R[6],Data_Reg,R[6]);
	Register4Bit R_7 (Clock,Button5,Load_R[7],Data_Reg,R[7]);

	ALU MyALU (R[1],R[2],R[0],F3,F4,C,V);
	 
	 
	always @(posedge Button0 or negedge Reset)
	begin
		if (Reset==1'b0)
			T <= 2'b00;
		else
			T <= T + 2'b01;
	end
	
	always @(*)
	begin
		case(T)
		2'b00 : begin SMux=1'b0; Load_R=8'b00000001; end
		2'b01 : begin SMux=1'b0; Load_R=8'b00000010; end
		2'b10 : begin SMux=1'b0; Load_R=8'b00000100; end
		2'b11 : begin 
						if (R[0]==4'b1111)
						begin
							SMux=1'b1; 
							Load_R=8'b00000000;
							Load_R[R[1]] = 1'b1;
						end
						else if (R[0]==4'b1110)
						begin
							SMux=1'b1; 
							Load_R=8'b00001000;
						end
						else
						begin
							SMux=1'b0; 
							Load_R=8'b00011000;
						end		
		
				  end
		endcase
	end
	
	assign Data_Reg = (R[0]==4'b1110)? R[R[1]] : R[2];
	
	assign Result_LCD = (R[0]!=4'b0111)? {4'b0,R[3]} : {R[4],R[3]};
	assign Result_7Sg = (R[0]!=4'b0111 && Button1==1'b1)? {4'b0,R[3]} :(Button1==1'b1)? {R[4],R[3]} : 8'b0;

endmodule
