module bit_carry_adder(a,b,cin,cout,sum);


//Input declaration
	//Array a,b declaration with size 16 to receive 16 bits
	input [15:0] a,b;
	//Declare variable 'cin' to receive carry in
	input cin;

//Output declaration
	//C16 is output from the 4-bit carriagelookahead circuit.
	output cout;
	//Declare array 'sum' with a size of 16 indicating the addition result 
	//of two 16-bit output from full adders
	output [15:0] sum;

//Wire declaration
	
	//Declare the G and P values from the first step of the carry-look head.
	wire [15:0] g,p;

	//Declares the C values output from the look head circuit.
	wire [16:0] c;
	
	//G and P values of the second step of the carry-look head circuit are received.
	wire [4:0] G,P;

	//It represents the C values output from the second carry-look head circuit.
	//These C values output C4, C8, C12, and C16.
	wire [3:0] cc;
	
/*Circuit Operation Phase*/

	//Assign c[0] a cin.
	assign c[0]=cin;
	/*The c[16] output from the second carriage-look head is assigned
	 to the cout and output to the simulation result.*/
	assign cout=c[16];

//Fulladder Operation

	/*In fulladder, 16 G and P values are primarily calculated and 
	handed over to the first step of the carry-look aheader module.*/

	/*Later, sum is calculated and output using the c array values
	 received from the carriage-look head.*/

	//Each full adder is calculated by receiving a, b, and c in an array of four bits.
	fulladder a1(a[3:0],b[3:0],c[3:0],sum[3:0],g[3:0],p[3:0]);
	fulladder a2(a[7:4],b[7:4],c[7:4],sum[7:4],g[7:4],p[7:4]);
	fulladder a3(a[11:8],b[11:8],c[11:8],sum[11:8],g[11:8],p[11:8]);
	fulladder a4(a[15:12],b[15:12],c[15:12],sum[15:12],g[15:12],p[15:12]);

//Carry-LookAhead Module Operating Steps

   //Look-ahead module in the first g and p calculation step
	/*Take the g and p values calculated by fulladder and calculate 
	the G and P values to be handed over to the next carry look header.*/

	/*The C0, C4, C8, and C12 values calculated and output from 
	the second CLA module are received, and the C0 to C15 values 
	to be handed over to the fulladder are calculated and delivered.*/

	/*G0 and P0 are calculated with the values of g[0]~g[3] and p[0]~p[3]
	 received from fulladder and handed over to the next look-ahead module,
	 and C0~C3 is calculated with the value of C0 and handed over to fulladder.*/
	CLA c1(g[3:0],p[3:0],cin,c[4:1],G[0],P[0]);

	/*G4 and P4 are calculated with the values of g[4]~g[7] and p[4]~p[7] 
	from the fulladder, and then handed over to the look-ahead module 
	from the bottom line with the C4 value received from the look-ahead 
	module and handed over to the fulladder.*/ 
	CLA c2(g[7:4],p[7:4],c[4],c[8:5],G[1],P[1]);

	//The principle of operation is the same as that of other look-ahead modules
	CLA c3(g[11:8],p[11:8],c[8],c[12:9],G[2],P[2]);
	CLA c4(g[15:12],p[15:12],c[12],c[16:13],G[3],P[3]);	

   //Look-ahead module in the second G and P calculation step
	/*C4,C8,C12,C16 are calculated and output from the values 
	of G0,G4,G8,G12 and P0,P4,P8,P12 received in the previous step.*/
	CLA bottom (G[3:0],P[3:0],cin,cc[3:0],G[4],P[4]);

	
		

	


endmodule


module fulladder(a,b,c,sum,Gout,Pout);

	input [3:0]a,b,c;
	output [3:0]sum;

	//In fulladder, the values of g and p are primarily calculated and handed over to the next look head module.
	output [3:0]Gout,Pout;
	
	assign Gout[0]=a[0]&b[0];
	assign Pout[0]=a[0]^b[0];

	//Calculate sum with the C values received from the look ahaed module.
	assign sum[0]=a[0]^b[0]^c[0];

	assign Gout[1]=a[1]&b[1];
	assign Pout[1]=a[1]^b[1];
	assign sum[1]=a[1]^b[1]^c[1];

	assign Gout[2]=a[2]&b[2];
	assign Pout[2]=a[2]^b[2];
	assign sum[2]=a[2]^b[2]^c[2];

	assign Gout[3]=a[3]&b[3];
	assign Pout[3]=a[3]^b[3];
	assign sum[3]=a[3]^b[3]^c[3];
	

endmodule

module CLA (G,P,cin,cout,GG,PP);

	input [3:0] G,P;

	//Calculate the following cs in advance with 'cin'.
	input cin;
	
	
	output [4:1]cout;

	output GG,PP;
	
	//The other c values are calculated with the input 'cin' value.
	assign cout[1]=G[0] | P[0]&cin;
	assign cout[2]=G[1] | P[1]&G[0]| P[1]&P[0]&cin;
	assign cout[3]=G[2] | P[2]&G[1]| P[2]&P[1]&G[0]| P[2]&P[1]&P[0]&cin;
	assign cout[4]=G[3] | P[3]&G[2] | P[3]&P[2]&G[1]|P[3]&P[2]&P[1]&G[0]|P[3]&P[2]&P[1]&P[0]&cin;

	//Calculate the new G and P values with the input g and p values.
	assign GG=G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0];
	assign PP=P[3]&P[2]&P[1]&P[0];
endmodule
