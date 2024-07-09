module MY_MEMORY (clk,w,r,address,dataIn,dataOut);
    input clk;
    input w;
    input r;
    input [7:0] dataIn;
    input [3:0] address;
    output reg [7:0] dataOut;

    reg [7:0] memory [0:15];

    always @(posedge clk) begin 
        if (r) dataOut <= memory[address];
        else if (w) memory[address] <= dataIn;
    end


endmodule