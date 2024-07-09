module MY_MEMORY (clk,w,r,address,dataIn,dataOut);
    input clk;
    input w;
    input r;
    input [7:0] dataIn;
    input [3:0] address;
    output reg [7:0] dataOut;

    reg [7:0] memory [0:15];

    assign memory[0] = 8'b01000001; // load ac = M[1] = 1
    assign memory[1] = 8'b00000001; // M[1] = 1 // add ac + m[1]
    assign memory[2] = 8'b00000001;
    assign memory[3] = 8'b00000001;
    assign memory[4] = 8'b00000001;
    assign memory[5] = 8'b00000001;
    assign memory[0] = 8'b00000001;
    assign memory[1] = 8'b00000001;
    assign memory[2] = 8'b00000001;
    assign memory[3] = 8'b00000001;
    assign memory[4] = 8'b00000001;
    assign memory[5] = 8'b00000001;
    always @(posedge clk) begin 
        if (r) dataOut <= memory[address];
        else if (w) memory[address] <= dataIn;
    end


endmodule