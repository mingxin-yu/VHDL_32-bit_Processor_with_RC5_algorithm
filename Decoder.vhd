----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:26:40 11/15/2018 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

entity Decoder is
    Port ( Instruction_Input  : in  STD_LOGIC_VECTOR (31 downto 0);
           Opcode : out  STD_LOGIC_VECTOR (5 downto 0);
           Funct : out  STD_LOGIC_VECTOR (5 downto 0);
           RReg1 : out  STD_LOGIC_VECTOR (4 downto 0);
           RReg2 : out  STD_LOGIC_VECTOR (4 downto 0);
			  WReg : out  STD_LOGIC_VECTOR (4 downto 0);
           Imm : out  STD_LOGIC_VECTOR (31 downto 0);
           RType : out  STD_LOGIC;
           IType : out  STD_LOGIC;
           JType : out  STD_LOGIC;
			  Ori_JAddr : out  STD_LOGIC_VECTOR (25 downto 0);
			  Halt  : out  STD_LOGIC);
end Decoder;

architecture Behavioral of Decoder is

Signal opc: STD_LOGIC_VECTOR (5 downto 0);
Signal RIJH: STD_LOGIC_VECTOR (3 downto 0);
Signal Ori_Imm: STD_LOGIC_VECTOR (15 downto 0);
Signal Imm_first_bit: STD_LOGIC;
Signal Imm_sign_extent_bits: STD_LOGIC_VECTOR (15 downto 0);

begin

opc <= Instruction_Input(31 downto 26);

Opcode <= opc;

RReg1 <= Instruction_Input(25 downto 21);
RReg2 <= Instruction_Input(20 downto 16);
WReg <= Instruction_Input(15 downto 11);

WITH opc SELECT

RIJH <= "1000" WHEN "000000", -- RType when 00
		 "0010" WHEN "001100", -- JType when 0c
		 "0001" WHEN "111111", -- HType whrn 3F
		 "0100" WHEN OTHERS;
		 
RType <= RIJH(3);
IType <= RIJH(2);
JType <= RIJH(1);
Halt <= RIJH(0);
		 
Funct <= Instruction_Input(5 downto 0);

Ori_Imm <= Instruction_Input(15 downto 0);

Imm_first_bit <= Instruction_Input(15);


WITH Imm_first_bit SELECT
Imm_sign_extent_bits <= x"0000" WHEN '0', -- Extent 0 when Imm is positive
								x"ffff" WHEN OTHERS;


Imm <= Imm_sign_extent_bits & Ori_Imm;

Ori_JAddr <= Instruction_Input(25 downto 0);

end Behavioral;

