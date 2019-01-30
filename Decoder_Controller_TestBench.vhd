--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:55:08 11/17/2018
-- Design Name:   
-- Module Name:   D:/AHD/AHD_Projects/Final_Project_Decoder_ControlUnit/Decoder_Controller_TestBench.vhd
-- Project Name:  Final_Project_Decoder_ControlUnit
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder_and_Controller
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Decoder_Controller_TestBench IS
END Decoder_Controller_TestBench;
 
ARCHITECTURE behavior OF Decoder_Controller_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder_and_Controller
    PORT(
         Instruction_Input : IN  std_logic_vector(31 downto 0);
			RReg1 : OUT std_logic_vector(4 downto 0);
			RReg2 : OUT std_logic_vector(4 downto 0);
			WReg : OUT  STD_LOGIC_VECTOR (4 downto 0);
			IMM : OUT std_logic_vector(31 downto 0);
         MemtoReg : OUT  std_logic;
         MemWrite : OUT  std_logic;
         Branch : OUT  std_logic;
         ALUControl : OUT  std_logic_vector(2 downto 0);
         ALUSrc : OUT  std_logic;
         RegDst : OUT  std_logic;
         RegWrite : OUT  std_logic;
			isIType : OUT  std_logic;	-- debug
			isRType : OUT  std_logic;  -- debug
         isJump : OUT  std_logic;
			Ori_JAddr : OUT  STD_LOGIC_VECTOR (25 downto 0);
         isHalt : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Instruction_Input : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
	signal RReg1 : std_logic_vector(4 downto 0);
	signal RReg2 : std_logic_vector(4 downto 0);
	signal WReg : std_logic_vector (4 downto 0);
	signal IMM : std_logic_vector(31 downto 0);
   signal MemtoReg : std_logic;
   signal MemWrite : std_logic;
   signal Branch : std_logic;
   signal ALUControl : std_logic_vector(2 downto 0);
   signal ALUSrc : std_logic;
   signal RegDst : std_logic;
   signal RegWrite : std_logic;
	signal isIType : std_logic;	-- debug
	signal isRType : std_logic;	-- debug
   signal isJump : std_logic;
	signal Ori_JAddr : STD_LOGIC_VECTOR (25 downto 0);
   signal isHalt : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder_and_Controller PORT MAP (
          Instruction_Input => Instruction_Input,
			 RReg1 => RReg1,
			 RReg2 => RReg2,
			 WReg => WReg,
			 IMM => IMM,
          MemtoReg => MemtoReg,
          MemWrite => MemWrite,
          Branch => Branch,
          ALUControl => ALUControl,
          ALUSrc => ALUSrc,
          RegDst => RegDst,
          RegWrite => RegWrite,
			 isIType => isIType,
			 isRType => isRType,
          isJump => isJump,
			 Ori_JAddr => Ori_JAddr,
          isHalt => isHalt
        );

   -- Clock process definitions
   --<clock>_process :process
   --begin
	--	<clock> <= '0';
	--	wait for <clock>_period/2;
	--	<clock> <= '1';
	--	wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		Instruction_Input <= "00000100000000010000000000000111";  --ADDI R1, R0, 7 
		wait for 100 ns;
		Instruction_Input <= "00000100000000100000000000001000";	 --ADDI R2, R0, 8 
		
		wait for 100 ns;
		Instruction_Input <= "00000000010000010001100000010000";  --ADD R3, R1, R2  
		wait for 100 ns;
		Instruction_Input <= "11111100000000000000000000000000";  --HAL 
		
		
		
		wait for 600 ns;
		Instruction_Input <= "00000100000000010000000000000010";  --ADDI R1, R0, 2
		wait for 100 ns;
		Instruction_Input <= "00000100000000110000000000001010";  --ADDI R3, R0, 10 
		
		wait for 100 ns;
		Instruction_Input <= "00000100000001000000000000001110";  --ADDI R4, R0, 14 
		wait for 100 ns;
		Instruction_Input <= "00000100000001010000000000000010";  --ADDI R5, R0, 2 

		
		wait for 100 ns;
		Instruction_Input <= "00100000011001000000000000000010";  --SW R4, 2(R3)   
		wait for 100 ns;
		Instruction_Input <= "00100000011000110000000000000001";  --SW R3, 1(R3) 

		wait for 100 ns;
		Instruction_Input <= "00000000100000110010000000000011";  --SUB R4, R4, R3
		wait for 100 ns;
		Instruction_Input <= "00001000000001000000000000000001";  --SUBI R4, R0, 1
		
		wait for 100 ns;
		Instruction_Input <= "00000000011000100010000000000101";  --AND R4, R2, R3
		wait for 100 ns;
		Instruction_Input <= "00001100010001000000000000001010";  --ANDI R4, R2, 10
		
		wait for 100 ns;
		Instruction_Input <= "00000000011000100010000000000111";  --OR R4, R2, R3
		wait for 100 ns;
		Instruction_Input <= "00011100011000100000000000000001";  --LW R2, 1, (R3)
		
		wait for 100 ns;
		Instruction_Input <= "00010000010001000000000000001010";  --ORI R4, R2, 10
		wait for 100 ns;
		Instruction_Input <= "00000000011000100010000000001001";  --NOR R4, R2, R3
		
		wait for 100 ns;
		Instruction_Input <= "00010100010001000000000000001010";  --SHL R4, R2, 10
		wait for 100 ns;
		Instruction_Input <= "00101000000001011111111111111110";  --BEQ R5, R0, -2
		
		wait for 100 ns;
		Instruction_Input <= "00100100100001010000000000000000";  --BLT R5, R4, 0
		wait for 100 ns;
		Instruction_Input <= "00101100100001010000000000000000";  --BNE R5, R4, 0
		
		wait for 100 ns;
		Instruction_Input <= "00110000000000000000000000010100";  --JMP 20
		wait for 100 ns;
		Instruction_Input <= "11111100000000000000000000000000";  --HAL

		
		

      -- insert stimulus here 

      wait;
   end process;

END;
