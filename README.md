# Single Cycle MIPS Implementation with VHDL
Single Cycle MIPS implementation using Xilinx ISE Design Suite 14.7 with VHDL.

## Design
The datapath that is used for as a reference in this project.

![MIPSDP](img/datapath.png)

## Components
- **MIPS Processor(Top Module)** (`MIPSProcessor.vhd`) 
	- Program Counter (`ProgramCounter.vhd`)
	- Program Counter Adder (`ProgramCounterAdder.vhd`)
	- Instruction Memory (`InstructionMemory.vhd`)
	- Register File (`RegisterFile.vhd`)
	- Mux (`Multiplexer.vhd`)
	- Sign Extender (`SignExtender.vhd`)
	- Shift Lefter (`ShifLefter.vhd`)
	- ALU (`ArithmeticLogicUnit.vhd`)
	- ALU Control (`ArithmeticLogicUnitController.vhd`)
	- Data Memory (`DataMemory.vhd`)
	- Control Unit (`ControlUnit.vhd`)

## Supported Instructions
- `add` (Addition)
- `sub` (Subtraction)
- `and` (Bitwise And)
- `or ` (Bitwise Or)
- `slt` (Set Less Than)
- `lw ` (Load Word)
- `sw ` (Store Word)
- `beq` (Branch Equal)
- `bne` (Branch Not Equal)
- `j  ` (Jump)

## Simulation
The implemented MIPS was simulated by ISim on `tb_MIPSProcessor.vhd` testbench file. Also names of the signals are changed on ISim. Check `simulation.wcfg` file.

![ss1](img/ss1.png)
![ss2](img/ss2.png)

