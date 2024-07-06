module ALU(clk, op1,op2,sel , out, co);

	input clk;
	input[7:0] op1;
	input[7:0] op2;
	input[2:0] sel;

	output[7:0] out;
	output co;

	wire[7:0] add;
    	wire addo;

	wire[7:0] ashl;
	wire ashlo;

    	wire[7:0] xnr;

	wire[7:0] div;
	wire divo;

    	wire[7:0] comp2s;
	
	

    	// instance modules 
	
    
    	MY_ADD add_Module(.op1(op1),.op2(op2),.out(add),.cout(addo));

	MY_ASHL ashl_Module(op1,op2,ashl,ashlo);

	MY_XNOR xnor_Module(op1,op2,xnr);

    	MY_DIV2 div2_Moudle(op1,div,divo);
	
	MY_COMP2S comp2s_Module(op1,comp2s);

    	


    	assign out = 
        	(sel == 3'b000) ? add :
        	(sel == 3'b001) ? ashl :
		(sel == 3'b010) ? xnr :
        	(sel == 3'b011) ? div : // for div by 2
		(sel == 3'b100) ? op1 :
		(sel == 3'b101) ? op1 :
        	(sel == 3'b110) ? comp2s : 
        	(sel == 3'b111) ? op1 : // for round func
        
		
        	8'bx;
    	assign co = 
        	(sel == 3'b000) ? addo :
        	(sel == 3'b001) ? ashlo :
		(sel == 3'b010) ? 1'b0 :
        	(sel == 3'b011) ? divo :
		(sel == 3'b100) ? 1'b0 :
		(sel == 3'b101) ? 1'b0 :
        	(sel == 3'b110) ? 1'b0 :
        	(sel == 3'b111) ? 1'b0 : 
        	1'bx;

endmodule
