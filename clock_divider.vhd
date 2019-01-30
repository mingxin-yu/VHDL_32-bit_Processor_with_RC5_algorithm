library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity clock_divider is
    Port ( 
           CLK 			: in  STD_LOGIC;
           divider_CLK 		: out  STD_LOGIC
			);
end clock_divider;

architecture Behavioral of clock_divider is

signal slowCLK: std_logic:='0';
signal i_cnt: std_logic_vector(19 downto 0):=x"00000";

begin
-----Creating a slowCLK of 500Hz using the board's 100MHz clock----
process(CLK)
begin
if (rising_edge(CLK)) then
if (i_cnt=x"10000")then --Hex(186A0)=Dec(100,000)
slowCLK<=not slowCLK; --slowCLK toggles once after we see 100000 rising edges of CLK. 2 toggles is one period.
i_cnt<=x"00000";
else
i_cnt<=i_cnt+'1';
end if;
end if;
end process;

divider_CLK <= slowCLK;

end Behavioral;
