library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_signed.all; -- 12022018
entity ALU is
port(
 SrcA,SrcB : in std_logic_vector(31 downto 0); -- src1, src2
 Alu_Control : in std_logic_vector(2 downto 0); -- function select
 Alu_Result: out std_logic_vector(31 downto 0); -- ALU Output Result
 zero: out std_logic -- Zero Flag
 );
end ALU;

architecture Behavioral of ALU is

COMPONENT Left_Rotate
PORT (a: in STD_LOGIC_VECTOR(31 DOWNTO 0);
      b: in STD_LOGIC_VECTOR(31 DOWNTO 0);
      o: out STD_LOGIC_VECTOR(31 DOWNTO 0));
END COMPONENT;

signal a: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal b: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal result: std_logic_vector(31 downto 0);
signal Left_Rotate_result: std_logic_vector(31 downto 0);
begin
a <= SrcA;
b <= SrcB;
 LR: Left_Rotate PORT MAP (a => a, b => b, o => Left_Rotate_result);
process(Alu_Control,SrcA,SrcB,Left_Rotate_result)
begin
 case Alu_Control is
 when "000" =>
  result <= SrcA + SrcB; -- add
 when "001" =>
  result <= SrcA - SrcB; -- sub -- branch if equal
 when "010" =>
  result <= SrcA and SrcB; -- and
 when "011" => 
  result <= SrcA or SrcB; -- or
 when "100" =>
  result <= SrcA nor SrcB; -- nor
 when "101" =>
 result <= Left_Rotate_result;
 when "110" =>
  if (SrcA<SrcB) then -- branch if less than
   result <= x"00000000";
  else 
   result <= x"00000001";
  end if;
 when "111" =>
    if (not(SrcA - SrcB = "00000000000000000000000000000000")) then -- branch if not equal
     result <= x"00000000";
    else 
     result <= x"00000001";
 end if;
 when others => result <= "00000000000000000000000000000101"; -- bug
 end case;
end process;
  zero <= '1' when result=x"00000000" else '0';
  Alu_Result <= result;
end Behavioral;