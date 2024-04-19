`timescale 1ns / 1ps
`include "target_gen.v"
module tb_target_gen;

// Inputs to the module
reg clk;
reg reset;
reg result_valid;

// Outputs from the module
wire [4:0] target_x;
wire [4:0] target_y;

// Instantiate the Unit Under Test (UUT)
target_gen uut (
    .clk(clk),
    .reset(reset),
    .result_valid(result_valid),
    .target_x(target_x),
    .target_y(target_y)
);

// Clock generation
initial begin
    clk = 0;
    forever #10 clk = ~clk; // Generate a clock with a period of 20ns
end

// Test sequence
initial begin
    $dumpfile("target_gen.vcd");
    $dumpvars;
    // Initialize inputs
    reset = 1;
    result_valid = 0;

    // Wait for global reset
    #100;
    reset = 0; // Release reset

    // Wait for a few clock cycles
    #100;

    // Trigger result_valid to generate first target
    @(posedge clk);
    result_valid = 1;
    @(posedge clk);
    result_valid = 0;

    // Wait and trigger result_valid to generate next target
    #100;
    @(posedge clk);
    result_valid = 1;
    @(posedge clk);
    result_valid = 0;
    // Wait and trigger result_valid to generate next target
    #100;
    @(posedge clk);
    result_valid = 1;
    @(posedge clk);
    result_valid = 0;
    // Wait and trigger result_valid to generate next target
    #100;
    @(posedge clk);
    result_valid = 1;
    @(posedge clk);
    result_valid = 0;
    // Wait and trigger result_valid to generate next target
    #100;
    @(posedge clk);
    result_valid = 1;
    @(posedge clk);
    result_valid = 0;
    // Wait and trigger result_valid to generate next target
    #100;
    @(posedge clk);
    result_valid = 1;
    @(posedge clk);
    result_valid = 0;

    // Finish simulation after some time
    #500;
    $finish;
end

// Monitor changes in the outputs
initial begin
    $monitor("At time %t, target_x = %d, target_y = %d",
             $time, target_x, target_y);
end

endmodule