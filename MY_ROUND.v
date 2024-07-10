module RoundUpPowerOf2(input [7:0] op1, output reg [7:0] rounded);

    reg [7:0] temp;

    always @(*) begin
        temp = op1 - 1;
        temp = temp | (temp >> 1);
        temp = temp | (temp >> 2);
        temp = temp | (temp >> 4);
        rounded = temp + 1;
    end

endmodule
