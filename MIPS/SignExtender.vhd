library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity SignExtender is
	port (
		SE_in  : in STD_LOGIC_VECTOR(15 downto 0);
		SE_out : out STD_LOGIC_VECTOR(31 downto 0)
	);
end SignExtender;

architecture Behavioral of SignExtender is

begin

	--SE_out <= X"0000" & SE_in when SE_in(15) = '0' else X"FFFF" & SE_in;
	SE_out <= STD_LOGIC_VECTOR(RESIZE(SIGNED(SE_in), 32));

end Behavioral;
