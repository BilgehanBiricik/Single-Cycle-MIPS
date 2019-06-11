library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ProgramCounterAdder is
	port (
		PCA_in  : in STD_LOGIC_VECTOR(31 downto 0);
		PCA_out : out STD_LOGIC_VECTOR(31 downto 0)
	);
end ProgramCounterAdder;

architecture Behavioral of ProgramCounterAdder is

begin

	process (PCA_in)
	begin
		PCA_out <= PCA_in + 4;
	end process;

end Behavioral;
