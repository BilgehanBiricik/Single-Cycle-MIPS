library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MIPSProcessor is
	port (
		CLK   : in STD_LOGIC;
		Reset : in STD_LOGIC
	);
end MIPSProcessor;

architecture Behavioral of MIPSProcessor is
	----------------------------------------------------------------------------------
	-- Components
	----------------------------------------------------------------------------------
	component ProgramCounter is
		port (
			CLK    : in STD_LOGIC;
			Reset  : in STD_LOGIC;
			PC_in  : in STD_LOGIC_VECTOR(31 downto 0);
			PC_out : out STD_LOGIC_VECTOR(31 downto 0)
		);
	end component;
	
	component ProgramCounterAdder is
		port (
			PCA_in  : in STD_LOGIC_VECTOR(31 downto 0);
			PCA_out : out STD_LOGIC_VECTOR(31 downto 0)
		);
	end component;
	
	component InstructionMemory is
		port (
			Address     : in STD_LOGIC_VECTOR(31 downto 0);
			Instruction : out STD_LOGIC_VECTOR(31 downto 0)
		);
	end component;
	
	component ControlUnit is
		port ( 
		  Opcode    : in  STD_LOGIC_VECTOR (5 downto 0);
		  RegDst    : out  STD_LOGIC;
		  Jump      : out  STD_LOGIC;
		  Branch_E  : out  STD_LOGIC;
		  Branch_NE : out  STD_LOGIC;
		  MemRead   : out  STD_LOGIC;
		  MemtoReg  : out  STD_LOGIC;
		  ALUOp     : out  STD_LOGIC_VECTOR (1 downto 0);
		  MemWrite  : out  STD_LOGIC;
		  ALUSrc    : out  STD_LOGIC;
		  RegWrite  : out  STD_LOGIC
		);
	end component;
	
	component Multiplexer is
		 generic (
			N : integer := 32
		 );
		 port ( 
			MUX_in_0   : in  STD_LOGIC_VECTOR(N - 1 downto 0);
			MUX_in_1   : in  STD_LOGIC_VECTOR(N - 1 downto 0);
			MUX_select : in  STD_LOGIC;
			MUX_out    : out  STD_LOGIC_VECTOR(N - 1 downto 0)
		);
	end component;
	
	component RegisterFile is
		port (
			CLK 		    : in STD_LOGIC;
			RegWrite 	    : in STD_LOGIC;
			Read_Register_1 : in STD_LOGIC_VECTOR(4 downto 0);
			Read_Register_2 : in STD_LOGIC_VECTOR(4 downto 0);	
			Write_Register  : in STD_LOGIC_VECTOR(4 downto 0);
			Write_Data      : in STD_LOGIC_VECTOR(31 downto 0);
			Read_Data_1     : out STD_LOGIC_VECTOR(31 downto 0);
			Read_Data_2     : out STD_LOGIC_VECTOR(31 downto 0)
		);
	end component;
	
	component ArithmeticLogicUnit is
		port (
			Input_1 	: in STD_LOGIC_VECTOR(31 downto 0);
			Input_2 	: in STD_LOGIC_VECTOR(31 downto 0);
			ALU_control : in STD_LOGIC_VECTOR(3 downto 0);
			ALU_result 	: out STD_LOGIC_VECTOR(31 downto 0);
			Zero 		: out STD_LOGIC
		);
	end component;
	
	component SignExtender is
		port (
			SE_in  : in STD_LOGIC_VECTOR(15 downto 0);
			SE_out : out STD_LOGIC_VECTOR(31 downto 0)
		);
	end component;
	
	component ArithmeticLogicUnitControl is
		port (
			ALUC_funct 	 	: in STD_LOGIC_VECTOR(5 downto 0);
			ALUOp 	 		: in STD_LOGIC_VECTOR(1 downto 0);
			ALUC_operation  : out STD_LOGIC_VECTOR(3 downto 0)
		);
	end component;
	
	component DataMemory is
		port ( 
			CLK		   : in STD_LOGIC;
			Address    : in  STD_LOGIC_VECTOR (31 downto 0);
			Write_Data : in  STD_LOGIC_VECTOR (31 downto 0);
			MemRead    : in  STD_LOGIC;
			MemWrite   : in  STD_LOGIC;
			Read_Data  : out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
	component ShiftLefter is
		generic (
			N : integer := 2;
			W : integer := 32
		);
		port (
			SL_in  : in STD_LOGIC_VECTOR(W - 1 downto 0);
			SL_out : out STD_LOGIC_VECTOR(W - 1 downto 0)
		);
	end component;
	
	----------------------------------------------------------------------------------
	-- Signals
	----------------------------------------------------------------------------------
	signal pcin : STD_LOGIC_VECTOR(31 downto 0);
	signal pcout : STD_LOGIC_VECTOR(31 downto 0);
	signal pc4out : STD_LOGIC_VECTOR(31 downto 0);
	
	signal instruction : STD_LOGIC_VECTOR(31 downto 0);
	signal rs, rd, rt : STD_LOGIC_VECTOR(4 downto 0);
	signal opcode : STD_LOGIC_VECTOR(5 downto 0);
	signal immediate : STD_LOGIC_VECTOR(15 downto 0);
	signal funct : STD_LOGIC_VECTOR(5 downto 0);
	signal jumpinst : STD_LOGIC_VECTOR(25 downto 0); 
	
	signal regdst, jump, branche, branchne, memread, memtoreg, memwrite, alusrc, regwrite : STD_LOGIC;
	signal aluop : STD_LOGIC_VECTOR(1 downto 0);
	
	signal regdstmuxout : STD_LOGIC_VECTOR(4 downto 0);
	signal memtoregmuxout : STD_LOGIC_VECTOR(31 downto 0);
	signal alusrcmuxout : STD_LOGIC_VECTOR(31 downto 0);
	signal branchmuxout : STD_LOGIC_VECTOR(31 downto 0);
	signal branchmuxselect : STD_LOGIC;
	
	signal rf_read_data_1, rf_read_data_2, dm_read_data : STD_LOGIC_VECTOR(31 downto 0);
	
	signal signimm : STD_LOGIC_VECTOR(31 downto 0);
	signal shifted_signimm : STD_LOGIC_VECTOR(31 downto 0);
	signal jumpaddr : STD_LOGIC_VECTOR(31 downto 0);
	
	signal alu_operation : STD_LOGIC_VECTOR(3 downto 0);
	signal alu_result : STD_LOGIC_VECTOR(31 downto 0);
	signal alu_zero : STD_LOGIC;
	signal alu_result_adder : STD_LOGIC_VECTOR(31 downto 0);
	
begin

	opcode <= instruction(31 downto 26);
	rs <= instruction(25 downto 21);
	rt <= instruction(20 downto 16);
	rd <= instruction(15 downto 11);
	funct <= instruction(5 downto 0);
	immediate <= instruction(15 downto 0);
	jumpinst <= instruction(25 downto 0);
	
	jumpaddr(31 downto 28) <= pc4out(31 downto 28);
	jumpaddr(27 downto 2) <= jumpinst;
	jumpaddr(1 downto 0) <= (others => '0');
	
	alu_result_adder <= pc4out + shifted_signimm;
	branchmuxselect <= ((branche and alu_zero) or (branchne and (not alu_zero)));
	
	----------------------------------------------------------------------------------
	-- Port Map of Components
	----------------------------------------------------------------------------------
	PC     	 	: ProgramCounter port map (CLK, Reset, pcin, pcout);
	PCA 		: ProgramCounterAdder port map (pcout, pc4out);
	SL 		 	: ShiftLefter port map (signimm, shifted_signimm);
	BranchMUX 	: Multiplexer generic map(32) port map (pc4out, alu_result_adder, branchmuxselect, branchmuxout);
	JumpMUX 	: Multiplexer generic map(32) port map (branchmuxout, jumpaddr, jump, pcin);
	IM 		 	: InstructionMemory port map (pcout, instruction);
	CU 		 	: ControlUnit port map (opcode, regdst, jump, branche, branchne, memread, memtoreg, aluop, memwrite, alusrc, regwrite);
	RegDstMUX 	: Multiplexer generic map(5) port map (rt, rd, regdst, regdstmuxout);
	RF 		 	: RegisterFile port map (CLK, regwrite, rs, rt, regdstmuxout, memtoregmuxout, rf_read_data_1, rf_read_data_2);
	SE 		 	: SignExtender port map (immediate, signimm);
	ALUSrcMUX 	: Multiplexer generic map(32) port map (rf_read_data_2, signimm, alusrc, alusrcmuxout);
	ALUC 		: ArithmeticLogicUnitControl port map (funct, aluop, alu_operation);
	ALU 		: ArithmeticLogicUnit port map (rf_read_data_1, alusrcmuxout, alu_operation, alu_result, alu_zero);
	DM 			: DataMemory port map (CLK, alu_result, rf_read_data_2, memread, memwrite, dm_read_data);
	MemtoRegMUX : Multiplexer generic map(32) port map (alu_result, dm_read_data, memtoreg, memtoregmuxout);

end Behavioral;

