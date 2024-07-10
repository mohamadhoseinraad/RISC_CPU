module tb_MY_ROUND;

    // Inputs
    reg [7:0] op1;

    // Outputs
    wire [7:0] rounded;

    RoundUpPowerOf2 testModule(
        .op1(op1), 
        .rounded(rounded)
    );

    initial begin
        // Initialize Inputs
        op1 = 8'b00000000;
        
        #100;

        // Test case 1: op1 = 5, expect rounded = 8
        op1 = 8'd5; #100;
        
        // Test case 2: op1 = 7, expect rounded = 8
        op1 = 8'd7; #100;
        
        // Test case 3: op1 = 9, expect rounded = 16
        op1 = 8'd9; #100;
        
        // Test case 4: op1 = 16, expect rounded = 16
        op1 = 8'd16; #100;
        
        // Test case 5: op1 = 17, expect rounded = 32
        op1 = 8'd17; #100;
        
    end
      
endmodule
