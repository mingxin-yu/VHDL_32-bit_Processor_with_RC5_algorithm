library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.all; -- ************************************ Be aware!!! This is Signed!!! *************************************

entity PC is
    Port ( clk : in  STD_LOGIC;
		   reset: in STD_LOGIC;
		   mode: in STD_LOGIC_VECTOR (1 downto 0);
           PC_input : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_output : out  STD_LOGIC_VECTOR (31 downto 0));
end PC;

architecture Behavioral of PC is

signal current_PC : STD_LOGIC_VECTOR (31 downto 0);
signal reset_PC : STD_LOGIC_VECTOR (31 downto 0);

begin

with mode select
reset_PC <= x"00000000" when "00", -- Input
            x"00000034" when "01", -- Encode
            x"0000038a" when "10", -- Decode
            x"000006fa" when others; -- Round Key Generation

process(clk, reset) 
	begin
	if(reset = '1') then
	    current_PC <= reset_PC;
	elsif(rising_edge(clk)) then -- 11252018 night
		current_PC <= PC_input;
	end if;
	end process;
	PC_output <= current_PC;

end Behavioral;

