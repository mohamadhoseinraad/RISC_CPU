module CPU_tb_xnor;

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
         memory[0] = 8'b01000101; // load AC <- M[5]
         memory[1] = 8'b10100111; //indirect address mode : Xnor M[M[7]] , AC = xor M[3] ,AC
         memory[2] = 8'b01010100; // store -> M[4] = 01010100 xnor 00000101 = 10101110 = h' ae
         memory[3] = 8'b01010100; //M[3] = h' 54
         memory[4] = 8'b00000000;
         memory[5] = 8'b00000101; //M[5] = 5
         memory[6] = 8'b00000000;
         memory[7] = 8'b00000011; // M[7] = 3
       
        $dumpvars(0, CPU_tb_xnor);
        clr = 1;
        #10;  
        clr = 0;
        #500 ;
        $finish;
    end

    always
        #5 clk = ~clk;

endmodule