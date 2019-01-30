-- GPX input devider 12142018
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity input_devider is
PORT (SW_1: in STD_LOGIC;
      reset:  in STD_LOGIC;
      switch: in STD_LOGIC_VECTOR(7 DOWNTO 0);
      i_cnt: out STD_LOGIC_VECTOR(4 DOWNTO 0);
      B_output: out STD_LOGIC_VECTOR(127 DOWNTO 0);
      ready: out STD_LOGIC
      );
end input_devider;

architecture Behavioral of input_devider is
SIGNAL i	: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
SIGNAL buf_1 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_2 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_3 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_4 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_5 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_6 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_7 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_8 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_9 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_10 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_11 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_12 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_13 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_14 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_15 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
SIGNAL buf_16 : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
--SIGNAL zero : STD_LOGIC_VECTOR(7 downto 0):= "00000000";




--SIGNAL output	: STD_LOGIC_VECTOR(127 DOWNTO 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
--SIGNAL buf	: STD_LOGIC_VECTOR(7 DOWNTO 0) := switch(7 DOWNTO 0);
BEGIN

PROCESS(SW_1,reset)
BEGIN

IF(reset='1') 
THEN  i<="00000";
buf_1<= "00000000";
buf_2<= "00000000";
buf_3<= "00000000";
buf_4<= "00000000";
buf_5<= "00000000";
buf_6<= "00000000";
buf_7<= "00000000";
buf_8<= "00000000";
buf_9<= "00000000";
buf_10<= "00000000";
buf_11<= "00000000";
buf_12<= "00000000";
buf_13<= "00000000";
buf_14<= "00000000";
buf_15<= "00000000";
buf_16<= "00000000";
ELSIF(SW_1'EVENT AND SW_1='1') THEN
  IF(i="10000") THEN i<="00000";
  ELSE i <= i + '1';
  END IF;  
  
  IF (i = "00000") THEN buf_1 <= switch; END IF;
  IF (i = "00001") THEN buf_2 <= switch; END IF;
  IF (i = "00010") THEN buf_3 <= switch; END IF;
  IF (i = "00011") THEN buf_4 <= switch; END IF;
  IF (i = "00100") THEN buf_5 <= switch; END IF;
  IF (i = "00101") THEN buf_6 <= switch; END IF;
  IF (i = "00110") THEN buf_7 <= switch; END IF;
  IF (i = "00111") THEN buf_8 <= switch; END IF;
  IF (i = "01000") THEN buf_9 <= switch; END IF;
  IF (i = "01001") THEN buf_10 <= switch; END IF;
  IF (i = "01010") THEN buf_11 <= switch; END IF;
  IF (i = "01011") THEN buf_12 <= switch; END IF;
  IF (i = "01100") THEN buf_13 <= switch; END IF;
  IF (i = "01101") THEN buf_14 <= switch; END IF;
  IF (i = "01110") THEN buf_15 <= switch; END IF;
  IF (i = "01111") THEN buf_16 <= switch; END IF;
  
  
END IF;



END PROCESS;


i_cnt <= i;
B_output <= 
buf_1 &
buf_2 &
buf_3 &
buf_4 &
buf_5 &
buf_6 &
buf_7 &
buf_8 &
buf_9 &
buf_10 &
buf_11 &
buf_12 &
buf_13 &
buf_14 &
buf_15 &
buf_16;

ready <= i(4);

end Behavioral;