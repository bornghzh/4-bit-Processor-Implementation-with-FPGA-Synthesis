
module ALU(
    input [3:0] A,
    input [3:0] B,
    input [3:0] Sel,
    output reg [3:0] F3,
    output reg [3:0] F4,
    output reg C,
    output reg V
    );

	wire [3:0] F_ADD , F_SUB , F_MUL1 , F_MUL2 , F_CMP , F_NAND , F_NOR , F_XOR;
	wire V_ADD , C_ADD , V_SUB , C_SUB;
	
	Add4Bit ADD (A,B,F_ADD,C_ADD,V_ADD);
	
	Sub4Bit SUB (A,B,F_SUB,C_SUB,V_SUB);
	
	Zarb ZRB (A,B,{F_MUL2,F_MUL1});
	
	nand (F_NAND[0],A[0],B[0]);
	nand (F_NAND[1],A[1],B[1]);
	nand (F_NAND[2],A[2],B[2]);
	nand (F_NAND[3],A[3],B[3]);

	nor (F_NOR[0],A[0],B[0]);
	nor (F_NOR[1],A[1],B[1]);
	nor (F_NOR[2],A[2],B[2]);
	nor (F_NOR[3],A[3],B[3]);
	
	xor (F_XOR[0],A[0],B[0]);
	xor (F_XOR[1],A[1],B[1]);
	xor (F_XOR[2],A[2],B[2]);
	xor (F_XOR[3],A[3],B[3]);
	
	always @(*)
	begin
		case (Sel)
		4'b0001 : begin F3=F_ADD;  F4=4'b0;    C=C_ADD;  V=V_ADD; end
		4'b0011 : begin F3=F_SUB;  F4=4'b0;    C=C_SUB;  V=V_SUB; end
		4'b0111 : begin F3=F_MUL1; F4=F_MUL2;  C=1'b0;   V=1'b0; end
		4'b1111 : begin F3=4'b0;   F4=4'b0;    C=1'b0;   V=1'b0; end
		4'b1110 : begin F3=4'b0;   F4=4'b0;    C=1'b0;   V=1'b0; end
		4'b1100 : begin F3=4'b0;   F4=4'b0;    C=1'b0;   V=1'b0; end
		4'b1000 : begin F3=F_NAND; F4=4'b0;    C=1'b0;   V=1'b0; end
		4'b1001 : begin F3=F_NOR;  F4=4'b0;    C=1'b0;   V=1'b0; end
		4'b1011 : begin F3=F_XOR;  F4=4'b0;    C=1'b0;   V=1'b0; end
		endcase
	end

endmodule
