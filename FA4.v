
module FA4(
    input [3:0] A,
    input [3:0] B,
    output [4:0] F
    );

	FA FA0 (A[0],B[0],1'b0,F[0],C0);
	FA FA1 (A[1],B[1],C0,F[1],C1);
	FA FA2 (A[2],B[2],C1,F[2],C2);
	FA FA3 (A[3],B[3],C2,F[3],F[4]);
	
endmodule
