module tb_ALU;

    reg clk;
    reg [7:0] op1, op2;
    reg [2:0] sel;
    wire [7:0] out;
    wire co;

    // Instantiate the ALU module
    ALU uut (
        .clk(clk),
        .op1(op1),
        .op2(op2),
        .sel(sel),
        .out(out),
        .co(co)
    );

    initial begin
        // Initialize clock
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize inputs
        //ADD test cout:0 out:3 
        op1 = 8'b00000001; op2 = 8'b00000010; sel = 3'b000;

        #10;
        // ADD test cout:1 out:3
        op1 = 8'b10000001; op2 = 8'b10000010; sel = 3'b000;

        #10;
        // ASHL test cout:0 out:2 
        op1 = 8'b00000001; op2 = 8'b00000010; sel = 3'b001;

        #10;
        // XNOR test cout:0 out:3
        op1 = 8'b11111110; op2 = 8'b00000010; sel = 3'b010;

        #10;
        //DIV2 test cout:1 out:4
        op1 = 8'b00001001; op2 = 8'b00000010; sel = 3'b011;

        #10;
        //LOAD
        op1 = 8'b00000001; op2 = 8'b00000010; sel = 3'b100;

        #10;
        //STORE
        op1 = 8'b00000001; op2 = 8'b00000010; sel = 3'b101;

        #10;
        //COMP2S test cout:0 out:ff
        op1 = 8'b00000001; op2 = 8'b00000010; sel = 3'b110;

        #10;        
        //ROUND test cout:0 out:16
        op1 = 8'b00001100; op2 = 8'b00000010; sel = 3'b111;

        #10;
        //ROUND test cout:0 out:16
        op1 = 8'b00001010; op2 = 8'b00000010; sel = 3'b111;

    end

endmodule
