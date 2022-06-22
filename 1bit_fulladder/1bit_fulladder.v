module Fulladder(X,Y,Cin,Cout,Sum);

//input decalaration
	
	//Declaration of X,Y to perform 1-bit addition operations
	input X,Y;
	
	//Declare Carry in
	input Cin;

//Output declaration

	//Cout declaration for place-round output of 1-bit operations
	output Cout;

	//Sum declaration to express the addition result of the 1-bit operation
	output Sum;

	//Equation to express Sum   (use XOR gate)
	assign Sum=X^Y^Cin;
	//Equation to determine whether Carry is present
	assign Cout=Cin&(X|Y)|(X&Y);
endmodule
