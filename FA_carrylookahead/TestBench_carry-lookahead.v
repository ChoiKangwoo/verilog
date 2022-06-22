`timescale 1ns/1ns
module testbench;

	//Declare the a and b arrays to be used in the operation
	reg [3:0] a,b;
	//Initial transferred C0 value
	reg cin;

	
	//You can see the sum value that has been added.
	wire [3:0] sum;

	//C4 value to be passed to the next bit from the addition.
	wire cout;

	//Execute 4-bit parallel adder module.
	AdderCLA carry_lookahead (a,b,cin,sum,cout);

	initial begin

	//The initial value of A and B was declared as 0 implemented in 4 bits.
	a=4'b0000;
	b=4'b0000;

	cin=1'b0;

	end

	/*It is implemented so that the values of a and b
	 increase by 1 every time a certain period of time passes.*/
	always #50 b=b+1'b1;
	always #100 a=a+1'b1;
	

endmodule