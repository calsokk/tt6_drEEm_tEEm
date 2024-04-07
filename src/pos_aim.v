module pos_aim (
    input wire clk,
    input wire reset,
    input wire left_x,
    input wire right_x,
    input wire left_aim,
    input wire right_aim,
    output wire [4:0] x_pos,
    output wire [2:0] aim_pos
);

    wire [4:0] next_x_pos = left_x ? x_pos == 5'd0 ? x_pos : x_pos - 1 :
                            right_x ? x_pos == 5'd31 ? x_pos : x_pos + 1;

    // x_pos
    dffr #(.WIDTH(5)) (
        .clk(clk),
        .r(reset),
        .d(next_x_pos),
        .q(x_pos)
    );

    wire [2:0] next_aim_pos = left_aim ? aim_pos == 3'd0 ? aim_pos : aim_pos - 1 :
                              right_aim ? aim_pos == 3'd6 ? aim_pos : aim_pos + 1;

    // aim_pos
    dffr #(.WIDTH(3)) (
        .clk(clk),
        .r(reset),
        .d(next_aim_pos),
        .q(aim_pos)
    );

endmodule