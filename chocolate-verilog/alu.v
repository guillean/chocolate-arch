module alu (
    input wire [2:0] alu_op,
    input wire [7:0] alu_x,
    input wire [7:0] alu_y,

    output wire [7:0] alu_output
);

assign alu_output = alu_x;

endmodule