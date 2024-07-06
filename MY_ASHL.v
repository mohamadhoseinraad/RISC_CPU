module MY_ADD(op1, op2, out, cout);
    input[7:0] op1, op2;
    output[7:0] out;
    output cout;
    
    assign cout = op1[7];
    assign out = op1 << op2;

endmodule