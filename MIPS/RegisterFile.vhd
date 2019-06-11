library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RegisterFile is
	port (
		CLK 				: in STD_LOGIC;
		RegWrite 		: in STD_LOGIC;
		Read_Register_1: in STD_LOGIC_VECTOR(4 downto 0);
		Read_Register_2: in STD_LOGIC_VECTOR(4 downto 0);	
		Write_Register : in STD_LOGIC_VECTOR(4 downto 0);
		Write_Data     : in STD_LOGIC_VECTOR(31 downto 0);
		Read_Data_1    : out STD_LOGIC_VECTOR(31 downto 0);
		Read_Data_2    : out STD_LOGIC_VECTOR(31 downto 0)
	);
end RegisterFile;

architecture Behavioral of RegisterFile is
	type Memory is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
	signal RegFile : Memory := (
		X"00000000", --$zero
		X"00000001", --$at
		X"00000002", --$v0
		X"00000003", --$v1
		X"00000004", --$a0
		X"00000005", --$a1
		X"00000006", --$a2
		X"00000007", --$a3
		X"00000000", --$t0
		X"00000000", --$t1
		X"00000000", --$t2
		X"00000000", --$t3
		X"00000000", --$t4
		X"00000000", --$t5
		X"00000000", --$t6
		X"00000000", --$t7
		X"00000000", --$s0
		X"00000000", --$s1
		X"00000000", --$s2
		X"00000000", --$s3
		X"00000000", --$s4
		X"00000000", --$s5
		X"00000000", --$s6
		X"00000000", --$s7
		X"00000000", --$t8
		X"00000000", --$t9
		X"00000000", --$k0
		X"00000000", --$k1
		X"10008000", --$global pointer
		X"7fffe838", --$stack pointer
		X"00000000", --$frame pointer
		X"00000000"  --$return address
	);

begin

	process (CLK)
	begin
		if (RISING_EDGE(CLK)) then
			if (RegWrite = '1') then
				RegFile(TO_INTEGER(UNSIGNED(Write_Register))) <= Write_Data;
			end if;
		end if;
	end process;
	
	Read_Data_1 <= RegFile(TO_INTEGER(UNSIGNED(Read_Register_1)));
	Read_Data_2 <= RegFile(TO_INTEGER(UNSIGNED(Read_Register_2)));		

end Behavioral;
