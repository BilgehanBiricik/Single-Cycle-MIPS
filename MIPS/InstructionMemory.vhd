library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity InstructionMemory is
	port (
		Address     : in STD_LOGIC_VECTOR(31 downto 0);
		Instruction : out STD_LOGIC_VECTOR(31 downto 0)
	);
end InstructionMemory;

architecture Behavioral of InstructionMemory is
	type Memory is array (0 to 15) of STD_LOGIC_VECTOR(31 downto 0);
	signal IMem : Memory := (
		 X"8C410001", -- LW $1, 1(2) --> $1 = MEM (0X02 + 0X01)
										 -- = MEM (03) = 0X33
		 X"00A41822", -- SUB $3, $5, $4 --> $3 = 0X05 - 0X04 = 0X01
		 X"00E61024", -- AND $2, $7, $6 --> $2 = 0X07 AND 0X06 = 0X06
		 X"00852025", -- OR $4, $4, $5 --> $4 = 0X04 OR 0X05 = 0X05
		 X"00C72820", -- ADD $5, $6, $7 --> $5 = 0X06 + 0X07 = 0X0D
		 X"1421FFFA", -- BNE $1, $1, -24 --> BRANCH NOT IF $1=$1
		 X"1022FFFF", -- BEQ $1, $2, -4 --> BRANCH IF $1=$2
		 X"0062302A", -- SLT $6, $3, $2 --> $6 = $3 < $2 = 0X01
											-- = 0X01 < 0X06
		 X"10210002", -- BEQ $1, $1, 2 --> BRANCH IF $1=$1
		 X"00000000", -- NOP --> NOP
		 X"00000000", -- NOP --> NOP
		 X"AC010002", -- SW $1, 2 --> $1 = 0X33 = MEMORY(02)
		 X"00232020", -- ADD $4, $1, $3 --> $4= 0X33 + 0X01 = 0X34
		 X"08000000", -- JUMP 0 --> JUMP TO PC = 00 
		 X"00000000",
		 X"00000000"
	);

begin
	
	process (Address)
	begin
		Instruction <= IMem(TO_INTEGER(UNSIGNED(Address)) / 4);
	end process;
	
end Behavioral;
