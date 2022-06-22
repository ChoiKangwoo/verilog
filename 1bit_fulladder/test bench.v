`timescale 1ns/1ns
module testbench;

	reg X,Y;
	reg Cin;

	wire Cout;
	wire Sum;

	Fulladder A1(X,Y,Cin,Cout,Sum);
	initial
	begin
		X=0; Y=0; Cin=0; #50;
		X=0; Y=1; Cin=0; #50;
		X=1; Y=0; Cin=0; #50;
		X=1; Y=1; Cin=0; #50;

		X=0; Y=0; Cin=1; #50;
		X=0; Y=1; Cin=1; #50;
		X=1; Y=0; Cin=1; #50;
		X=1; Y=1; Cin=1; #50;
	end
endmodule
