/*The ripple carrier adder of the 2's complement method
 had a delay of 4 gates, but this module using the 1's complement method 
has a  maximum delay of 8 gates because c4 enters the carryin again.*/

module fouradder(a,b,S,cin,Cout);

//Input declaration

	//Declaration of a and b in 4 bits
	input [3:0] a;
	input [3:0] b;

	//Initial Carryin Value Declaration
	input cin;

//Output declaration

	//S array declaration with sum output with final result value
	output [3:0] S;
	//C array declaration with carry output with final result value,
	//However, cout does not appear as the final output value due to the calculation of around carry.
	//The value of the final cout is always zero.
	output Cout;
	
//wire declaration

	//Declare the carryout value output from the first addition
	wire cout;
	

	//Declaration of the s array output from the first addition
	//This array is the input value of the second  calculation with cout.
	wire [3:0] s;
	

	//Declare required c array as input of carryin for sequential calculations
	wire [3:1] c;
	wire [3:1] c2;
	

	
	
//The first additional section
	fulladder a0 (a[0],b[0],cin,s[0],c[1]);
	fulladder a1 (a[1],b[1],c[1],s[1],c[2]);
	fulladder a2 (a[2],b[2],c[2],s[2],c[3]);
	fulladder a3 (a[3],b[3],c[3],s[3],cout);
//The second additional section
	/*For the second calculation, cout was entered
 	as carryin in the s-array and 0-bit addition calculation.*/
	fulladder A0 (s[0],1'b0,cout,S[0],c2[1]);
	fulladder A1 (s[1],1'b0,c2[1],S[1],c2[2]);
	fulladder A2 (s[2],1'b0,c2[2],S[2],c2[3]);
	fulladder A3 (s[3],1'b0,c2[3],S[3],Cout);




/*In the 4-bit addition calculation, 
the end-arround carriage occurs maximum once. 
 Therefore, the value of the output Cout will only appear as 0.*/

/*The problem is that if the output carry out in the first 4 bit addition is 0,
 the second addition is not required.
Therefore, there are cases where there is an unnecessary delay of 8 gates.*/

	

endmodule
	

//It is a  1-bit fulladder module composed of three inputs and two outputs.
module fulladder(a,b,cin,sum,cout);

//Input a,b and c of 1-bit
	input a,b,cin;

//Output sum and cout
	output sum;
	output cout;
	
	//The result of sum is the XOR operation.
	assign sum=a^b^cin;

	//The result of cout is aC+bC+ab
	assign cout=cin&(a|b)|(a&b);

endmodule
	
