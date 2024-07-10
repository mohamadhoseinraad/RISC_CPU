module tb_MY_ASHL;

    // Inputs
    reg [7:0] op1;

    // Outputs
    wire [7:0] out;
    wire cout;

    MY_ASHL testModule (
        .op1(op1), 
        .out(out),
        .cout(cout)
    );

    initial begin
        op1 = 8'b00000000;
        
        #100;

        // out= 15*2 = 30
        op1 = 8'b00001111; #10;
        
        // out = 1*2 = 2
        op1 = 8'b00000001; #10;
    end
      
endmodule
