module MY_MEMORY_TB;

    // Testbench signals
    reg clk;
    reg w;
    reg r;
    reg [7:0] dataIn;
    reg [3:0] address;
    wire [7:0] dataOut;

    // Instantiate the MY_MEMORY module
    MY_MEMORY uut (
        .clk(clk),
        .w(w),
        .r(r),
        .address(address),
        .dataIn(dataIn),
        .dataOut(dataOut)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10 time unit period clock

    initial begin
        // Initialize signals
        clk = 0;
        w = 0;
        r = 0;
        dataIn = 8'd0;
        address = 4'd0;

        // Test case 1: Write to memory
        #10;
        address = 4'd3;
        dataIn = 8'h03;
        w = 1;
        #10;
        w = 0;

        // Test case 2: Read from memory
        #10;
        address = 4'd7;
        dataIn = 8'h07;
        w = 1;
        #10;
        w=0;
        r = 1;

        // Test case 3: Write to another address
        #10;
        address = 4'd7;

        // Test case 4: Read from another address
        #10;
        address = 4'd3;



    end

    // Monitor the signals
    initial begin
        $monitor("Time: %d, clk: %b, w: %b, r: %b, address: %d, dataIn: %h, dataOut: %h",
                 $time, clk, w, r, address, dataIn, dataOut);
    end

endmodule
