library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ArithmeticLogicUnitControl is
	port (
		ALUC_funct 	 	: in STD_LOGIC_VECTOR(5 downto 0);
		ALUOp 	 		: in STD_LOGIC_VECTOR(1 downto 0);
		ALUC_operation : out STD_LOGIC_VECTOR(3 downto 0)
	);
end ArithmeticLogicUnitControl;

architecture Behavioral of ArithmeticLogicUnitControl is

begin

	ALUC_operation(3) <= '0';
	ALUC_operation(2) <= ALUOp(0) or (ALUOp(1) and ALUC_funct(1));
	ALUC_operation(1) <= (not ALUOp(1)) or (not ALUC_funct(2));
	ALUC_operation(0) <= (ALUC_funct(3) or ALUC_funct(0)) and ALUOp(1);

end Behavioral;
