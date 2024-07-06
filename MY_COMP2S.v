module MY_COMP2S(op1, out);
    input[7:0] op1;
    output[7:0] out;

    assign out = ~(op1)+ 8'b00000001 ;

endmodule