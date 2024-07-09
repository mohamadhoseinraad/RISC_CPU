module CPU_tb;

    // Memory
    reg [7:0] memory [0:15];

    // Ports
    reg clk = 0;
    reg clr = 0;
    wire read;
    wire write;
    wire[7:0] memoryIn, memoryOut;
    wire[3:0] address;

    always @(posedge clk) begin
        if (write) memory[address] <= memoryIn;
    end

    assign memoryOut = memory[address];

    CPU
        CPU_dut (
            .clk (clk),
            .clr(clr),
            .read(read),
            .write(write),
            .memoryOut(memoryOut),
            .memoryIn(memoryIn),
            .address(address)
        );

    initial
    begin
        
        $readmemb("memoryLdCompare.list", memory);
        
        $dumpvars(0, CPU_tb);
        clr = 1;
        #10;  
        clr = 0;
        #500 ;
        $finish;
    end

    always
        #5 clk = ~clk;

endmodule
