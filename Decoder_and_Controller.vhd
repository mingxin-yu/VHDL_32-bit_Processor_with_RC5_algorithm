----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:39:21 11/17/2018 
-- Design Name: 
-- Module Name:    Decoder_and_Controller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder_and_Controller is
    Port ( 
              clk: in  STD_LOGIC;
              clr: in  STD_LOGIC;
              Instruction_Input : in  STD_LOGIC_VECTOR (31 downto 0);
			  RReg1 : OUT std_logic_vector(4 downto 0);
			  RReg2 : OUT std_logic_vector(4 downto 0);
			  WReg : out  STD_LOGIC_VECTOR (4 downto 0);
			  IMM : OUT std_logic_vector(31 downto 0);
           MemtoReg : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           Branch : out  STD_LOGIC;
           ALUControl : out  STD_LOGIC_VECTOR (2 downto 0);
           ALUSrc : out  STD_LOGIC;
           RegDst : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
			  isIType : out  STD_LOGIC;   -- Debug
			  isRType : out  STD_LOGIC;   -- Debug
           isJump : out  STD_LOGIC;
			  Ori_JAddr : out  STD_LOGIC_VECTOR (25 downto 0);
           isHalt : out  STD_LOGIC);
end Decoder_and_Controller;

architecture Behavioral of Decoder_and_Controller is

	COMPONENT Decoder
	PORT(
		Instruction_Input : IN std_logic_vector(31 downto 0); 		         
		Opcode : OUT std_logic_vector(5 downto 0);
		Funct : OUT std_logic_vector(5 downto 0);
		RReg1 : OUT std_logic_vector(4 downto 0);
		RReg2 : OUT std_logic_vector(4 downto 0);
		WReg : out  STD_LOGIC_VECTOR (4 downto 0);
		Imm : OUT std_logic_vector(31 downto 0);
		RType : OUT std_logic;
		IType : OUT std_logic;
		JType : OUT std_logic;
		Ori_JAddr : out  STD_LOGIC_VECTOR (25 downto 0);
		Halt : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT Control_Unit
	PORT(
	   clk : in  STD_LOGIC;
	   clr : in  STD_LOGIC;
		Opcode : IN std_logic_vector(5 downto 0);
		Funct : IN std_logic_vector(5 downto 0);
		RType : IN std_logic;
		IType : IN std_logic;
		--JType : IN std_logic;
		MemtoReg : OUT std_logic;
		MemWrite : OUT std_logic;
		Branch : OUT std_logic;
		ALUControl : OUT std_logic_vector(2 downto 0);
		ALUSrc : OUT std_logic;
		RegDst : OUT std_logic;
		RegWrite : OUT std_logic
		);
	END COMPONENT;

Signal opcode: STD_LOGIC_VECTOR (5 downto 0):=(others=>'0');
Signal funct: STD_LOGIC_VECTOR (5 downto 0):=(others=>'0');
Signal rtype: STD_LOGIC:='0';
Signal itype: STD_LOGIC:='0';
Signal MemWriteSignal: STD_LOGIC:='0';
begin
MemWrite<=MemWriteSignal;
	Inst_Decoder: Decoder PORT MAP(
		Instruction_Input => Instruction_Input,
		Opcode => opcode,
		Funct => funct,
		RReg1 => RReg1,
		RReg2 => RReg2,
		WReg => WReg,
		Imm => IMM,
		RType => rtype,
		IType => itype,
		JType => isJump,
		Ori_JAddr => Ori_JAddr,
		Halt => isHalt
	);
	
	Inst_Control_Unit: Control_Unit PORT MAP(
	   clk=>clk,
	    clr=>clr,
		Opcode => opcode,
		Funct => funct,
		RType => rtype,
		IType => itype,
		MemtoReg => MemtoReg,
		MemWrite => MemWriteSignal,
		Branch => Branch,
		ALUControl => ALUControl,
		ALUSrc => ALUSrc,
		RegDst => RegDst,
		RegWrite => RegWrite
	);
	
	isRType <= rtype; --Debug
	isIType <= itype; --Debug

end Behavioral;

