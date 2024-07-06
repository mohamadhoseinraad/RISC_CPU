module MY_REGD (clk,inc,load,clr,in,out);
    
    input clk;
    input inc;
    input load;
    input clr;
    input[7:0] in;

    output reg[7:0] out;

    always @(posedge clk) begin 
        if (clr) out <= 8'b0;
        else if (load) out <= in;
        else if (inc) out <= out +1;
    end


endmodule