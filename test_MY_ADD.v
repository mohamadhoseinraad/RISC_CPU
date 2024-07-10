module tb_MY_ADD;

    // Inputs
    reg [7:0] op1;
    reg [7:0] op2;

    // Outputs
    wire [7:0] out;
    wire cout;


    MY_ADD testModule (
        .op1(op1), 
        .op2(op2),
        .out(out),
        .cout(cout)
    );

    initial begin
        // Initialize Inputs
        op1 = 8'b00000000;
        op2 = 8'b00000000;
        
        #100;

        // Test case 1: simple addition
        op1 = 8'b00001111; op2 = 8'b00001111; #10;
 
        // Test case 2: addition with carry out
        op1 = 8'b11110000; op2 = 8'b00001111; #10;

    end
      
endmodule
