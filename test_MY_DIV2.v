module test_MY_DIV2;

    // Inputs
    reg [7:0] op1;

    // Outputs
    wire [7:0] out;
    wire cout;

    // Instantiate the Unit Under Test (UUT)
    MY_DIV2 uut (
        .op1(op1), 
        .out(out),
        .cout(cout)
    );

    initial begin
        // Initialize Inputs
        op1 = 8'b00000000;
        
        #100;

        op1 = 8'b00001110; #10;

        op1 = 8'b10101011; #10;
    end
      
endmodule
