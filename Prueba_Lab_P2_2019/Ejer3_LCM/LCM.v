 
`define FINAL_STATE   3'd4
`define INVALID_STATE 3'dx

module LCM(
    input clk,
    input rst,
    input [31:0] n1,
    input [31:0] n2,
    output [31:0] result
);

    reg [31:0] minMultiple;
    reg [31:0] minMultipleP;
    reg [2:0] cs /*verilator public*/;
    reg [2:0] ns /*verilator public*/;

    assign result = minMultiple;

    always @ (*) begin
        case (cs)
            'd0: begin
                if(n1>n2)
                    ns = 3'd1;
                else
                    ns = 3'd2;
            end
            'd1:
                ns = 3'd3;

            'd2:
                ns = 3'd3;
            'd3: begin
                if((minMultipleP % n1 == 0) && (minMultipleP % n2 == 0))
                    ns = 3'd3;
                else
                    ns = 3'd5;
            end
            'd4:
                ns = 3'd4;
            'd5:
                ns = 3'd4;
            `FINAL_STATE: ns = `FINAL_STATE;
            default: ns = `INVALID_STATE;
        endcase;
    end

    always @ (*) begin
        case (cs)
            'd0: minMultipleP = minMultiple;
            'd1: minMultipleP = n1;
            'd2: minMultipleP = n2;

            'd3: minMultipleP = minMultiple;
            'd4: minMultipleP = minMultiple;
            'd5:
                minMultipleP = minMultiple + 1;
            `FINAL_STATE:
                minMultipleP = minMultiple;
            default:
                minMultipleP = 32'dx;
        endcase
    end

    always @ (posedge clk) begin
        if (rst)
            cs <= 'd0;
        else
            cs <= ns; 
    end

    always @ (posedge clk) begin
        minMultiple <= minMultipleP;
    end
endmodule
