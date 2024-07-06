module MY_SCOUNTER (clk,inc,clr,out);
    input clk,inc,clr;
    output reg [2:0] out;

    always @(posedge clk) begin
        if(clr) out <= 3'b0;
        else if(inc) out <= out +1;
    end
endmodule