library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity ProgramCounter is
	port (
		CLK    : in STD_LOGIC;
		Reset  : in STD_LOGIC;
		PC_in  : in STD_LOGIC_VECTOR(31 downto 0);
		PC_out : out STD_LOGIC_VECTOR(31 downto 0)
	);
end ProgramCounter;

architecture Behavioral of ProgramCounter is

begin
		
		process (CLK, Reset)
		begin
			if (Reset = '1') then
				PC_out <= X"00000000";
			elsif (RISING_EDGE(CLK)) then
				PC_out <= PC_in;
			end if;
		end process;
	
end Behavioral;


