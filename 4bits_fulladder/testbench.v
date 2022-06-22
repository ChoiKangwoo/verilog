`timescale 1ns/1ns
module testfulladder;
//input declaration
	//input  array variable a,b with size 4
	reg [3:0] a;
	reg [3:0] b;
	//variavle of carry
	reg cin;
	
	
// output declaration
	//result of sum
	wire [3:0] S;
	//result of Cout
	wire Cout;

	fouradder adder(a,b,S,cin,Cout);

	initial begin
	
	a=4'b0000;
	b=4'b0000;
	cin=1'b0;
	
	
	/*The always syntax was used to increase a and b by 1 every certain time, 
	and the cin value was initialized to 0 or 1.*/


	end
	always #50 b=b+1'b1;
	always #100 a=a+1'b1;
	always #150 cin=~cin;

	
	



	endmodule
	
	
