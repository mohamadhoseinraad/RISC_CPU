`timescale 1ns/1ns
module CPU_tb;

    // Memory
    reg [7:0] memory [0:15];

    // Ports
    reg clk = 0;
    reg rst = 0;
    wire read;
    wire write;
    wire[7:0] memIn, memOut;
    wire[3:0] address;

    always @(posedge clk) begin
        if (write) memory[address] <= memIn;
    end

    assign memOut = memory[address];

    CPU
        CPU_dut (
            clk,rst,read,write,address,memIn,memOut
        );

    initial
    begin
        
        $readmemb("comd.list", memory);
        
        $dumpvars(0, CPU_tb);
        rst = 1;
        #10;  
        rst = 0;
        #500 ;
        $finish;
    end

    always
        #5 clk = ~clk;

endmodule
