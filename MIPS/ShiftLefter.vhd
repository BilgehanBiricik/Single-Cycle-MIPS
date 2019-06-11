library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ShiftLefter is
	generic (
		N : integer := 2;
		W : integer := 32
	);
	port (
		SL_in  : in STD_LOGIC_VECTOR(W - 1 downto 0);
		SL_out : out STD_LOGIC_VECTOR(W - 1 downto 0)
	);
end ShiftLefter;

architecture Behavioral of ShiftLefter is

begin

	SL_out(W - 1) <= SL_in(W - 1);
	SL_out(W - 2 downto N) <= SL_in(W - 2 - N downto 0);
	SL_out(N - 1 downto 0) <= (others => '0');

end Behavioral;

