module MY_ASHL(op1, out, cout);
    input[7:0] op1;
    output[7:0] out;
    output cout;
    
    assign cout = op1[7];
    assign out = op1 << 1;

endmodule