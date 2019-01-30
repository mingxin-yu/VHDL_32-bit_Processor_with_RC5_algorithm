
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.all; -- ************************************ Be aware!!! This is Signed!!! *************************************
use work.MyType.all;

entity MIPS_Processor is
    Port ( 
			  clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           
           inputData: in  std_logic_vector(127 downto 0); -- input data
           inputRdy: in std_logic;
           mode_select: IN std_logic_vector(1 downto 0);
           
           current_PC : out  STD_LOGIC_VECTOR (31 downto 0);
		   current_Inst : out  STD_LOGIC_VECTOR (31 downto 0);
		   rom_data_out: out MEM;
		   reg_data:out REG
			  );
end MIPS_Processor;

architecture Behavioral of MIPS_Processor is

            signal inputDataSig: std_logic_vector(127 downto 0); -- input data
            signal inputRdySig:std_logic;

            signal rom_data: MEM;
            signal reg_array: REG;

	COMPONENT PC
	PORT(
		clk : IN std_logic;
		reset: IN STD_LOGIC;
		mode: IN std_logic_vector(1 downto 0);
		PC_input : IN std_logic_vector(31 downto 0);          
		PC_output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
		COMPONENT IMEM
	PORT(
		PC_Address : IN std_logic_vector(31 downto 0);          
		instruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
		COMPONENT Decoder_and_Controller
	PORT(
	     clr: in  STD_LOGIC;
	     clk:  in  STD_LOGIC;
		Instruction_Input : IN std_logic_vector(31 downto 0);          
		RReg1 : OUT std_logic_vector(4 downto 0);
		RReg2 : OUT std_logic_vector(4 downto 0);
		WReg : OUT std_logic_vector(4 downto 0);
		IMM : OUT std_logic_vector(31 downto 0);
		MemtoReg : OUT std_logic;
		MemWrite : OUT std_logic;
		Branch : OUT std_logic;
		ALUControl : OUT std_logic_vector(2 downto 0);
		ALUSrc : OUT std_logic;
		RegDst : OUT std_logic;
		RegWrite : OUT std_logic;
		isIType : OUT std_logic;		-- debug, able to remove
		isRType : OUT std_logic;		-- debug, able to remove
		isJump : OUT std_logic;
		Ori_JAddr : OUT std_logic_vector(25 downto 0);
		isHalt : OUT std_logic
		);
	END COMPONENT;
	
	
	COMPONENT register_file_VHDL
	PORT(
	    clr: in std_logic;
		clk : IN std_logic;
		WrtEnable : IN std_logic;
		WrtReg : IN std_logic_vector(4 downto 0);
		WrtData : IN std_logic_vector(31 downto 0);
		RReg1 : IN std_logic_vector(4 downto 0);
		RReg2 : IN std_logic_vector(4 downto 0);          
		ReadData1 : OUT std_logic_vector(31 downto 0);
		ReadData2 : OUT std_logic_vector(31 downto 0);
		reg_data : inout REG		
		);
	END COMPONENT;
	
	
	COMPONENT ALU
	PORT(
		SrcA : IN std_logic_vector(31 downto 0);
		SrcB : IN std_logic_vector(31 downto 0);
		Alu_Control : IN std_logic_vector(2 downto 0);          
		Alu_Result : OUT std_logic_vector(31 downto 0);
		zero : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT DMEM
	PORT(
	   clr: IN std_logic;
		clk : IN std_logic;
		Wrt_Enable : IN std_logic;
		Read_Enable : IN std_logic;
		Address : IN std_logic_vector(31 downto 0);
		WrtData : IN std_logic_vector(31 downto 0);    -- 16-bit DMEM      
        ReadData : OUT std_logic_vector(31 downto 0);   -- 16-bit DMEM
        
        inputData: in  std_logic_vector(127 downto 0); -- input data
        inputRdy: in std_logic;
        
        rom_data_out: out MEM
		);
	END COMPONENT;	

-- PC module signals	
signal current_PC_address: STD_LOGIC_VECTOR(31 DOWNTO 0);

signal PC_plus_2_address: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal PC_branch_address: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal PC_jump_address: STD_LOGIC_VECTOR(31 DOWNTO 0);

signal next_PC_address: STD_LOGIC_VECTOR(31 DOWNTO 0);

-- IMEM module signals
signal current_instruction: STD_LOGIC_VECTOR(31 DOWNTO 0);

-- Decoder + Controller signals

-- Decode Contents
signal rreg1: STD_LOGIC_VECTOR(4 DOWNTO 0);
signal rreg2: STD_LOGIC_VECTOR(4 DOWNTO 0);
signal wreg: STD_LOGIC_VECTOR(4 DOWNTO 0);

signal imm: STD_LOGIC_VECTOR(31 DOWNTO 0);

-- Control Signals
signal mem_to_reg: STD_LOGIC;
signal mem_write: STD_LOGIC;

signal branch: STD_LOGIC;

signal alu_control: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal alu_src: STD_LOGIC;

signal reg_dst: STD_LOGIC;
signal reg_write: STD_LOGIC;

signal is_Itype: STD_LOGIC;	-- debug, able to remove
signal is_Rtype: STD_LOGIC;	-- debug, able to remove

signal is_Jump: STD_LOGIC;
signal ori_Jaddr: STD_LOGIC_VECTOR(25 DOWNTO 0);

signal is_Halt: STD_LOGIC;

-- RF
signal read_data_1: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal read_data_2: STD_LOGIC_VECTOR(31 DOWNTO 0); 

signal wrt_data: STD_LOGIC_VECTOR(31 DOWNTO 0); -- result

signal wrt_reg: STD_LOGIC_VECTOR(4 DOWNTO 0);

-- ALU
signal alu_input_2: STD_LOGIC_VECTOR(31 DOWNTO 0);

signal alu_result: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal zero: STD_LOGIC;										-- for branching

-- MEM
signal mem_read_data: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal mem_read_data_16: STD_LOGIC_VECTOR(31 DOWNTO 0);     -- 16-bit DMEM

-- Branch Address
signal branch_address: STD_LOGIC_VECTOR(31 DOWNTO 0);

-- Jump/Branch/Halt Signal/PC+2/

signal ZB: STD_LOGIC_VECTOR(1 DOWNTO 0); -- zero & branch

signal is_Branch: STD_LOGIC;
signal BJH: STD_LOGIC_VECTOR(2 DOWNTO 0);
		
begin

	Inst_PC: PC PORT MAP(
		clk => clk,
		reset => reset,
		mode => mode_select,
		PC_input => next_PC_address,	
		PC_output => current_PC_address
	);
	
	PC_plus_2_address <= current_PC_address + "10";  -- PC+2
	
	Inst_IMEM: IMEM PORT MAP(
		PC_Address => current_PC_address,
		instruction => current_instruction
	);
	
	Inst_Decoder_and_Controller: Decoder_and_Controller PORT MAP(
	   clr=>reset,
	   clk=>clk,
		Instruction_Input => current_instruction,
		RReg1 => rreg1,
		RReg2 => rreg2,
		WReg => wreg,
		IMM => imm,
		MemtoReg => mem_to_reg,
		MemWrite => mem_write,
		Branch => branch,
		ALUControl => alu_control,
		ALUSrc => alu_src,
		RegDst => reg_dst,
		RegWrite => reg_write,
		isIType => is_Itype,		-- debug, able to remove
		isRType => is_Rtype,		-- debug, able to remove
		isJump => is_Jump,
		Ori_JAddr => ori_Jaddr,
		isHalt => is_Halt
	);
	
	-- calculating brancing address
	
	--PC_branch_address <= PC_plus_2_address + (Imm(29 downto 0)&"00");  -- to discuss (PC + 2 + [SignExtended Imm (29:0) & "00"])
	PC_branch_address <= PC_plus_2_address + Imm;  -- to discuss (PC + 2 + [SignExtended Imm (31:0)])
	
	-- calculating jump address
	
	PC_jump_address <= PC_plus_2_address(31 downto 28) & "00" & ori_Jaddr ;	-- to discuss
	
	
	Inst_register_file_VHDL: register_file_VHDL PORT MAP(
	    clr=>reset,
		clk => clk,
		WrtEnable => reg_write,
		WrtReg => wrt_reg,
		WrtData => wrt_data,
		RReg1 => rreg1,
		RReg2 => rreg2,
		ReadData1 => read_data_1,
		ReadData2 => read_data_2,
		reg_data=>reg_array
	);
	reg_data<=reg_array;
	
	-- ALU input select
	
	with alu_src select
	alu_input_2 <= read_data_2 when '0',
						imm when others;
	
	
						
	Inst_ALU: ALU PORT MAP(
		SrcA => read_data_1,
		SrcB => alu_input_2,
		Alu_Control => alu_control,
		Alu_Result => alu_result,
		zero => zero
	);

	
	Inst_DMEM: DMEM PORT MAP(
	    clr=>reset,
		clk => clk,
		Wrt_Enable => mem_write,
		Read_Enable => mem_to_reg,
		Address => alu_result,
		WrtData => read_data_2,       -- 16-bit DMEM
        ReadData => mem_read_data_16,     -- 16-bit DMEM
        
        inputData => inputDataSig, -- input data
        inputRdy => inputRdySig,
        
        rom_data_out=>rom_data
	);
	
	mem_read_data <= mem_read_data_16;   -- 16-bit DMEM    //modified!

	-- Write Data input select
	
	with mem_to_reg select     --是否与dmem相关
	wrt_data <= alu_result when '0',
					mem_read_data when others;
					
					
	-- Write Reg input select
	
	with reg_dst select
	wrt_reg <= rreg2 when '0',
				  wreg when others;
				  
	-- PC input select
	ZB <= zero & branch;    
    with ZB select
    is_Branch <= '1' when "11",
                     '0' when others;
                     
    BJH <= is_Branch & is_Jump & is_Halt; 
	with BJH select
	next_PC_address <= PC_plus_2_address when "000", -- not branch, not jump, not halt
				          PC_branch_address when "100", -- branch
							 PC_jump_address when "010", -- jump
							 current_PC_address when others; -- 4.8 halt pc stop

	current_PC <= current_PC_address;
	current_Inst <= current_instruction;   
    rom_data_out<=rom_data;
    
   inputDataSig <= inputData; -- input data 1214 gpx
   inputRdySig <= inputRdy;   -- input data 1214 gpx
    
end Behavioral;

