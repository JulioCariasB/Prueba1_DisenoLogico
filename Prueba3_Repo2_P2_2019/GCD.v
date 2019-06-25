module GCD(
	input clk,
	input rst,
	input[31:0] a,
	input[31:0] b,
	output[31:0] result
);

	reg[31:0] numa;
	reg[31:0] numb;
	reg[31:0] numap;
	reg[31:0] numbp;

	reg[2:0] cs;
	reg[2:0] ns;

	assign result = numap;

	//Logica del current state
	always @ (posedge clk) begin
		if(rst) begin
			cs <= 3'd0;
		end
		else begin
			cs <= ns;
		end
	end

	//Logica del next state
	always @ (*) begin
		case(cs)
			3'd0:
				ns = 3'd1;
			3'd1: begin
				if(numa!=numb)
					ns = 3'd2;
				else
					ns = 3'd5;
			end
			3'd2: begin
				if(numa>numb)
					ns = 3'd3;
				else
					ns = 3'd4;
			end
			3'd3:
				ns = 3'd1;
			3'd4:
				ns = 3'd1;
			3'd5:
				ns = 3'd5;
			default:
				ns = 3'dx;
		endcase				
	end

	//Logica de las salidas
	always @ (*) begin
		case(cs)
			3'd0:
				{numap, numbp} = {a, b}; 
			3'd1:;

			3'd2:;

			3'd3:
				{numap} = {numa-numb};
			3'd4:
				{numbp} = {numb-numa};
			3'd5:
				{numa} = {numap};
		endcase
	end

	//Logica de los primes
		always @ (posedge clk) begin
		numa <= numap;
		numb <= numbp;
		
	end
	


endmodule