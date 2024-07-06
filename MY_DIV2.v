module MY_DIV2(op1, out, cout);
    input[7:0] op1;
    output[7:0] out;
    output cout;
    
    assign cout = op1[0];
    assign out = op1 >>> 1;

endmodule