
module Mux2_1(
    input [3:0] Data_Sw,
    input [3:0] Data_Reg,
    input S_Mux,
    output [3:0] O_Mux
    );

	assign O_Mux = (S_Mux==0)? Data_Sw : Data_Reg;

endmodule
