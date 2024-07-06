module MY_XNOR(op1, op2, out);
    input[7:0] op1, op2;
    output[7:0] out;

    assign out = ~(op1 ^ op2);

endmodule