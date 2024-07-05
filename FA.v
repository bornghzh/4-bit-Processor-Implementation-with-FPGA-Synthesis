
module FA(
    input A,
    input B,
    input Cin,
    output Sum,
    output Carry
    );

	xor (W1,A,B);
	xor (Sum,W1,Cin);
	
	and (W2,A,B);
	and (W3,W1,Cin);
	
	or (Carry,W2,W3);

endmodule
