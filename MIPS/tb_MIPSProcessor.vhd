LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY tb_MIPSProcessor IS
END tb_MIPSProcessor;
 
ARCHITECTURE behavior OF tb_MIPSProcessor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MIPSProcessor
    PORT(
         CLK : IN  std_logic;
			Reset : IN std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
	signal Reset : std_logic := '0';

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MIPSProcessor PORT MAP (
          CLK => CLK,
			 Reset => Reset
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	
		Reset <= '1';
		wait for 10 ns;	
		Reset <= '0';
		wait for 100 ns;

      wait for CLK_period*10;
		
   end process;

END;
