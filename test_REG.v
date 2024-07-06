
module tb_MY_REGA;

    reg clk;
    reg inc;
    reg load;
    reg clr;
    reg [3:0] in_data;
    wire [3:0] out_data;

    MY_REGA my_rega (
        .clk(clk),
        .inc(inc),
        .load(load),
        .clr(clr),
        .in(in_data),
        .out(out_data)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        load = 1;
        in_data = 4'b1010;
        #10;
        load = 0;

        
        clr = 1;
        #10;
        clr = 0;

        

        inc = 1;
        #10;
        inc = 0;


    end

endmodule
