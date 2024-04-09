module target_gen(
    input wire clk,
    input wire reset,
    input wire result_valid,
    output wire [4:0] target_x,
    output wire [4:0] target_y
);

// PRNG state and target generation logic
reg [31:0] rng_state;
wire [31:0] next_rng_state;
wire [4:0] next_target_x, next_target_y;

// Update RNG state logic (simple LFSR)
assign next_rng_state = {rng_state[30:0], rng_state[31] ^ rng_state[21] ^ rng_state[1] ^ rng_state[0]};

// Assign next target coordinates
assign next_target_y = rng_state[0];  // Randomly 0 or 1 for Y coordinate
assign next_target_x = rng_state[4:0]; // 5 bits for X coordinate, range 0 to 31

// PRNG state register
dffre #(.WIDTH(32)) rng_register (
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
