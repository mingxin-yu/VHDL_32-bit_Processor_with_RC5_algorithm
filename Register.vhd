library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  
use IEEE.std_logic_unsigned.all;
use work.MyType.all;
-- VHDL code for the register file of the MIPS Processor

entity register_file_VHDL is
port (
    clr: in std_logic;
	clk: in std_logic;
	WrtEnable: in std_logic;
	WrtReg: in std_logic_vector(4 downto 0);
	WrtData: in std_logic_vector(31 downto 0);
	RReg1: in std_logic_vector(4 downto 0);
	RReg2: in std_logic_vector(4 downto 0);
	ReadData1: out std_logic_vector(31 downto 0);
	ReadData2: out std_logic_vector(31 downto 0);
	reg_data:inout REG
	
);
end register_file_VHDL;

architecture Behavioral of register_file_VHDL is

signal reg_array: REG;    

begin
ReadData1 <= reg_array(CONV_INTEGER(RReg1));
ReadData2 <= reg_array(CONV_INTEGER(RReg2));

process(clk,clr) 
begin
if(clr='1') then 
reg_array<=(others=>x"00000000");
elsif (falling_edge(clk)) then -- 11252018 night debug(04)
            if(WrtEnable = '1') then
                reg_array(CONV_INTEGER(WrtReg)) <= WrtData;
            end if;
     end if;
end process;

reg_data<=reg_array;

end Behavioral;