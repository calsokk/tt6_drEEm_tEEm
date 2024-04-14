module tt_um_target_gen(
    input wire clk,
    input wire reset,
    input wire result_valid,
    output wire [4:0] target_x,
    output wire [4:0] target_y
);

// PRNG state and target generation logic
reg [7:0] rng_state; // Now using an 8-bit state
wire [7:0] next_rng_state;
wire [4:0] next_target_x, next_target_y;

// Update RNG state logic (simple 8-bit LFSR)
// Feedback taps are at bits 7, 5, 4, and 3
assign next_rng_state = {rng_state[6:0], rng_state[7] ^ rng_state[5] ^ rng_state[4] ^ rng_state[3]};

// Assign next target coordinates
assign next_target_y = rng_state[0];  // Randomly 0 or 1 for Y coordinate
assign next_target_x = rng_state[4:0]; // 5 bits for X coordinate, range 0 to 31

// PRNG state register
dffre #(.WIDTH(8)) rng_register ( // Modified WIDTH to 8
    .clk(clk),
    .r(reset),
    .en(result_valid),
    .d(next_rng_state),
    .q(rng_state)
);

// Target X coordinate register
dffre #(.WIDTH(5)) target_x_register (
    .clk(clk),
    .r(reset),
    .en(result_valid),
    .d(next_target_x),
    .q(target_x)
);

// Target Y coordinate register
dffre #(.WIDTH(5)) target_y_register (
    .clk(clk),
    .r(reset),
    .en(result_valid),
    .d(next_target_y),
    .q(target_y)
);

endmodule
