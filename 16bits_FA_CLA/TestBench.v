`timescale 1ns/1ns
module testbench;

	reg [15:0] a,b;
	reg cin;

	wire [15:0] sum;
	wire cout;

	bit_carry_adder BCA (a,b,cin,cout,sum);

	initial begin

		//As a result of the simulation, verilog seems to be calculated based on 2's complement.
		//I will attach the binary version wave and the decimal version wave together.
		
		/*In the 16-bit calculation, the range of representation 
		of the complement of 2 is -37268 to 37268.*/

		//a(=21845) + b(=-21846) + c(=0)= -1 , cout(=c16)=0
		a=16'b0101010101010101;b=16'b1010101010101010;cin=0;#50; 
	
		//a(=-2) + b(=6) + c(=0)= 4 , cout(=c16)=1
		a=16'b1111111111111110;b=16'b0000000000000110;cin=0;#50;

		//a(=2751) + b(=-26923) + c(=1)= -24171 , cout(=c16)=0
		a=16'b0000101010111111;b=16'b1001011011010101;cin=1;#50; 

		//a(=-32317) + b(=-24580) + c(=0)= 8639 , cout(=c16)=1  "overhead"
		a=16'b1000000111000011;b=16'b1001111111111100;cin=0;#50;

		//a(=255) + b(=-256) + c(=1)= 0 , cout(=c16)=1
		a=16'b0000000011111111;b=16'b1111111100000000;cin=1;#50;

		//a(=7281) + b(=9990) + c(=1)= 17272 , cout(=c16)=0
		a=16'b0001110001110001;b=16'b0010011100000110;cin=1;#50;
		

	
			

	end
	
	

endmodule
