`timescale 1ps / 1ps
`include "controls.v"

module controls_tb();

    reg clk = 0;
    reg reset = 1;
    reg move_left, move_right, aim_left, aim_right, shoot, start_new_game;

    wire left_x, right_x, left_aim, right_aim, shoot_out;
    wire [4:0] select;

    controls dut (
        .clk(clk),
        .reset(reset),
        .move_left(move_left),
        .move_right(move_right),
        .aim_left(aim_left),
        .aim_right(aim_right),
        .shoot(shoot),
        .start_new_game(start_new_game),
        .left_x(left_x),
        .right_x(right_x),
        .left_aim(left_aim),
        .right_aim(right_aim),
        .shoot_out(shoot_out),
        .select(select)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("controls_tb.vcd");
        $dumpvars;

        reset = 0;
        #10;

        // Test case 1: Only move_left pressed
        move_left = 1;
        #10;
        move_left = 0;

        // Test case 2: Only move_right pressed
        //move_right = 1;
        #40;
        //move_right = 0;

        // Test case 3: Only aim_left pressed
        aim_left = 1;
        #10;
        aim_left = 0;

        // Test case 4: Only aim_right pressed
        aim_right = 1;
        #10;
        aim_right = 0;

        // Test case 5: Only shoot pressed
        shoot = 1;
        #10;
        shoot = 0;

        // Test case 6: Multiple buttons pressed
        move_left = 1;
        move_right = 1;
        aim_left = 1;
        aim_right = 1;
        shoot = 1;
        #10;
        move_left = 0;
        move_right = 0;
        aim_left = 0;
        aim_right = 0;
        shoot = 0;

        // Test case 7: New game
        start_new_game = 1;
        #10;
        start_new_game = 0;

        // Add more test cases as needed

        #10;
        
        $display("Test complete");
        $finish;
    end
endmodule
