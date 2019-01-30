library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
package MyType is

TYPE MEM is ARRAY (0 to 63) of std_logic_vector(15 downto 0);
TYPE REG is ARRAY (0 to 31) of std_logic_vector(31 downto 0);

end MyType;
