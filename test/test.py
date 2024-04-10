# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: MIT

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_pos_aim(dut):
  dut._log.info("Start")
  
  # Our example module doesn't use clock and reset, but we show how to use them here anyway.
  clock = Clock(dut.clk, 10, units="us")
  cocotb.start_soon(clock.start())

  # Reset
  dut._log.info("Reset")
  dut.left_x.value = 0
  dut.right_x.value = 0
  dut.left_aim.value = 0
  dut.right_aim.value = 0
  dut.reset.value = 1
  await ClockCycles(dut.clk, 10)
  dut.reset.value = 0

  # Set the input values, wait one clock cycle, and check the output
  dut._log.info("Test")

  # Check x_pos incrementing from 0 -> 31
  # Also checks if x_pos does not go past 6
  for i in range(0, 33): 
    dut.right_x.value = 1
    await ClockCycles(dut.clk, 1)

  # Check x_pos decrementing from 31 -> 0
  # Also checks if x_pos does not go past 0
  for i in range(0, 33):
    dut.left_x.value = 1
    await ClockCycles(dut.clk, 1)

  # Check aim_pos incrementing from 0 -> 6
  # Also checks if x_pos does not go past 6
  for i in range(0, 8): 
    dut.right_aim.value = 1
    await ClockCycles(dut.clk, 1)

  # Check aim_pos incrementing from 6 -> 0
  # Also checks if x_pos does not go past 0
  for i in range(0, 8): 
    dut.left_aim.value = 1
    await ClockCycles(dut.clk, 1)

  assert dut.x_pos.value == 0 and dut.aim_pos.value == 0
