----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:07:15 11/17/2018 
-- Design Name: 
-- Module Name:    Control_Unit - Behavioral 
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

entity Control_Unit is
    Port ( 
    clr: in  STD_LOGIC;
    clk: in  STD_LOGIC;
    Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           Funct : in  STD_LOGIC_VECTOR (5 downto 0);
			  RType : in  STD_LOGIC;
           IType : in  STD_LOGIC;
           --JType : in  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           Branch : out  STD_LOGIC;
           ALUControl : out  STD_LOGIC_VECTOR (2 downto 0);
           ALUSrc : out  STD_LOGIC;
           RegDst : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC);
end Control_Unit;

architecture Behavioral of Control_Unit is

begin

PROCESS (clr, Opcode, Funct, RType, IType)

BEGIN
if(clr='1') then
end if;
	IF(RType = '1') THEN 
		IF (Funct = "000001") THEN			-- 0x01 ADD
			ALUControl <= "000";
		ELSIF (Funct = "000011") THEN 	-- 0x03 SUB
			ALUControl <= "001";
		ELSIF (Funct = "000101") THEN  	-- 0x05 AND
			ALUControl <= "010";
		ELSIF (Funct = "000111") THEN 	-- 0x07 OR
			ALUControl <= "011";
		ELSIF (Funct = "001001") THEN  	-- 0x09 NOR
			ALUControl <= "100";			
		END IF;
		
		ALUSrc <= '0'; 					-- Select Rd as ALU oprand 2
		RegWrite <= '1';
		RegDst <= '1'; 					-- Using Rt(15:11) as destination register
		MemWrite <= '0';
		MemtoReg <= '0';
		Branch <= '0';

	
	ELSIF(IType = '1') THEN
	    ALUSrc <= '1';
		IF (OpCode = "000001") THEN	 -- 0x01 ADDI
			ALUControl <= "000";
		ELSIF (OpCode = "000010") THEN -- 0x02 SUBI
			ALUControl <= "001";
		ELSIF (OpCode = "000011") THEN -- 0x03 ANDI
			ALUControl <= "010";
		ELSIF (OpCode = "000100") THEN -- 0x04 ORI
			ALUControl <= "011";
		ELSIF (OpCode = "000101") THEN -- 0x05 SHL
			ALUControl <= "101";	
		ELSIF (OpCode = x"07") THEN -- 0x07 LW
			ALUControl <= "000";			 -- ALU ADD
		ELSIF (OpCode = x"08") THEN -- 0x08 SW
			ALUControl <= "000";			 -- ALU ADD
		ELSIF (OpCode = x"09") THEN -- 0x09 BLT
			ALUControl <= "110";
			ALUSrc <= '0';
		ELSIF (OpCode = x"0a") THEN -- 0x0a BEQ
			ALUControl <= "001";
			ALUSrc <= '0';
		ELSIF (OpCode = x"0b") THEN -- 0x0b BNE
			ALUControl <= "111";			 -- ALU SUB
			ALUSrc <= '0';
		END IF;
		
		--ALUSrc <= '1';

		IF (OpCode < x"07") THEN   -- ADDI, SUBI, ANDI, ORI, SHL
			RegWrite <= '1';
			RegDst <= '0';				-- Using Rd(20:16) as destination register
			MemWrite <= '0';
			MemtoReg <= '0';
			Branch <= '0';
			
		ELSIF (OpCode = x"07") THEN -- LW
			RegWrite <= '1';
			RegDst <= '0';
			MemWrite <= '0';
			MemtoReg <= '1';
			Branch <= '0';
		
		ELSIF (OpCode = x"08") THEN -- SW
			RegWrite <= '0';
			RegDst <= '0';
			MemWrite <= '1';
			MemtoReg <= '0';
			Branch <= '0';
			
		ELSIF (OpCode > x"08") THEN -- BLT, BEQ, BNE
			RegWrite <= '0';
			RegDst <= '0';
			MemWrite <= '0';
			MemtoReg <= '0';
			Branch <= '1';
		END IF;
		
	ELSE
		ALUControl <= "000";			-- All Set 0
		ALUSrc <= '0'; 					
		RegWrite <= '0';
		RegDst <= '0';
		MemWrite <= '0';
		MemtoReg <= '0';
		Branch <= '0';
	END IF;

END PROCESS;

end Behavioral;

