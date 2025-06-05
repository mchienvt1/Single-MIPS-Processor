# MIPS Processor Implementation

## Introduction

This project presents the implementation of a 32-bit single-cycle MIPS processor, designed using Verilog HDL. The MIPS (Microprocessor without Interlocked Pipeline Stages) architecture is a widely-used RISC (Reduced Instruction Set Computer) architecture known for its simplicity and efficiency. Our implementation focuses on a single-cycle design, where each instruction is executed in a single clock cycle.

The processor supports a subset of MIPS instructions, including arithmetic operations, logical operations, memory access instructions, and control flow instructions. It is a fundamental project for understanding how processors work at the microarchitecture level and serves as a basis for more advanced concepts in computer architecture.

## Features

- **Single-Cycle Design**: Executes each instruction in a single clock cycle.
- **Instruction Set**: Supports key MIPS instructions like `add`, `sub`, `and`, `or`, `slt`, `lw`, `sw`, `beq`, `j`, and others.
- **Modular Design**: The processor is designed in a modular fashion with distinct modules: controller, datapath, instruction memory and data memory.
- **Verilog Implementation**: The processor is described using Verilog HDL, making it synthesizable for FPGA implementation.

## Interface Overview
The instruction and data memories are separated from the main processor and connected by address and data busses. This is more realistic, because most real processors have external memory. It also illustrates how the processor can communicate with the outside world.
The processor is composed of a datapath and a controller. The controller, in turn, is composed of the Control and the ALUControl. Figure below shows a block diagram of the single-cycle MIPS processor interfaced to external memories.

1. **Controller**: The controller (composed of the ALU Control and the Control unit) operates with the datapath to ensure
the correct execution of instructions.
2. **Datapath**: The datapath of the processor consists of four main components: the Program Counter (PC), the Arithmetic Logic Unit (ALU), the Register File, and the overall Datapath.
3. **Instruction Memory**: Component of the computer system that stores
the instructions of a program.
4. **Data Memory**: Data memory stores and retrieves data actively processed by the ALU.

The diagram below provides a high-level view of the MIPS processor interface:

![Processor Interface](https://github.com/mchienvt1/Single-MIPS-Processor/blob/main/processor_interface.png)


## Project Structure

- **RTL**: Contains the Verilog source files for each module of the processor.
- **Verification**: Includes the testbenches used for simulation and verification of the processor.
- **Specification**: Documentation and diagrams related to the project.
- **README.md**: This file, providing an overview of the project.

## Simulation and Testing

The project includes a comprehensive testbench that simulates the execution of various MIPS instructions. The testbench covers different scenarios, ensuring the correct operation of arithmetic, logical, memory, and control flow instructions.

To run the simulation, use the following command in your Verilog simulation environment.
