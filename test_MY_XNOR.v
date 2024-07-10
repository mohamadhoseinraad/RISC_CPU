module tb_MY_XNOR;

    // Inputs
    reg [7:0] op1;
    reg [7:0] op2;

    // Outputs
    wire [7:0] out;


    MY_XNOR testModule (
        .op1(op1), 
        .op2(op2), 
        .out(out)
    );

    initial begin
        op1 = 8'b00000000;
        op2 = 8'b00000000;
        
        #100;

	// out = 00
        op1 = 8'b10101010; op2 = 8'b10101010; #10;
        
	// out= ff
        op1 = 8'b11110000; op2 = 8'b00001111; #10;
    end
      
endmodule
