library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMemory is
    port ( 
		CLK		  : in STD_LOGIC;
		Address    : in  STD_LOGIC_VECTOR (31 downto 0);
		Write_Data : in  STD_LOGIC_VECTOR (31 downto 0);
		MemRead    : in  STD_LOGIC;
		MemWrite   : in  STD_LOGIC;
		Read_Data  : out  STD_LOGIC_VECTOR (31 downto 0)
	 );
end DataMemory;

architecture Behavioral of DataMemory is
	type Memory is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
	signal DMem : Memory := (
		X"00000055",
		X"000000AA",
		X"00000011",
		X"00000033",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000"
	);

begin

	process (CLK)
	begin
		if (RISING_EDGE(CLK)) then
			if (MemWrite = '1') then
				DMem(TO_INTEGER(UNSIGNED(Address))) <= Write_Data;
			end if;
			if (MemRead = '1') then
				Read_Data <= DMem(TO_INTEGER(UNSIGNED(Address)));
			end if;
		end if;
	end process;

end Behavioral;
