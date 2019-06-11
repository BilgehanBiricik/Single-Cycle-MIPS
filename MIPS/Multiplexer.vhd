library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexer is
	 generic (
		N : integer := 32
	 );
    port ( 
		MUX_in_0   : in  STD_LOGIC_VECTOR(N - 1 downto 0);
		MUX_in_1   : in  STD_LOGIC_VECTOR(N - 1 downto 0);
		MUX_select : in  STD_LOGIC;
		MUX_out    : out  STD_LOGIC_VECTOR(N - 1 downto 0)
	);
end Multiplexer;

architecture Behavioral of Multiplexer is

begin

	MUX_out <= MUX_in_0 when (MUX_select = '0') else MUX_in_1;

end Behavioral;

