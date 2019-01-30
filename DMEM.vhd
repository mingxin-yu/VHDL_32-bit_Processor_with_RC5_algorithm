library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use work.MyType.all;
entity DMEM is
port (
 clr: in std_logic;
 clk: in std_logic;
 Wrt_Enable: in std_logic;
 Read_Enable: in std_logic;
 Address: in std_logic_vector(31 downto 0);
 WrtData: in std_logic_vector(31 downto 0); -- 16-bit DMEM
 ReadData: out  std_logic_vector(31 downto 0); -- 16-bit DMEM
 
 inputData: in  std_logic_vector(127 downto 0); -- input data
 inputRdy: in std_logic;
 
 rom_data_out: out MEM
);
end DMEM;

architecture Behavioral of DMEM is
 signal DMEM_buffer_address: std_logic_vector(6 downto 0);				-- to find the cell in RAM
 signal RD_Buffer: std_logic_vector(31 downto 0);	
 
 signal rom_data: MEM:=MEM'(
x"0000",x"0000", x"0000",x"0000", x"46F8",x"E8C5", x"460C",x"6085", 
x"70F8",x"3B8A", x"284B",x"8303", x"513E",x"1454", x"F621",x"ED22",
x"3125",x"065D", x"11A8",x"3A5D", x"D427",x"686B", x"713A",x"D82D",
x"4B79",x"2F99", x"2799",x"A4DD", x"A790",x"1C49", x"DEDE",x"871A",
x"36C0",x"3196", x"A7EF",x"C249", x"61A7",x"8BB8", x"3B0A",x"1D2B",
x"4DBF",x"CA76", x"AE16",x"2167", x"30D7",x"6B0A", x"4319",x"2304",
x"F6CC",x"1431", x"6504",x"6380", x"0000",x"0000", x"0000",x"0000",
x"0000",x"0000", x"0000",x"0000", x"B7E1",x"5163", x"9E37",x"79B9"
  );
  
  --input
  signal input_data_buf: std_logic_vector(127 downto 0):=(others=>'1');
  signal RD_Input_Buffer: std_logic_vector(31 downto 0);
  signal RD_Reg_Buffer: std_logic_vector(31 downto 0);
  
  signal Rd_enable_and_address: std_logic_vector(7 downto 0);			
  --input

BEGIN
DMEM_buffer_address <= Address(6 downto 0); -- iNPUT

--process(clk,clr)
--begin
--if(clr='1')then
--    RD_Buffer<=x"00000000";
--elsif(rising_edge(clk)) then
 --   if (Read_Enable = '1') then
--	    if (Address < x"00000040" ) then    --52
--              -- 16-bit DMEM
--         else
--            RD_Buffer  <= x"afffffff"; -- 16-bit DMEM
--         end if;
--    end if;
--	if (Wrt_Enable = '1') thenrom_data(CONV_INTEGER(DMEM_buffer_address)) <= WrtData;  -- 16-bit DMEM
--		RD_Buffer  <= x"bfffffff"; -- 16-bit DMEM
 --   end if;    
--end if;	
--end process;
--		
process(clk)
begin 
if(rising_edge(clk)) then 
    if(Wrt_Enable = '1') then
        --rom_data(CONV_INTEGER(DMEM_buffer_address))<= WrtData(15 downto 0);
        --rom_data(CONV_INTEGER(DMEM_buffer_address)+1)<= WrtData(31 downto 16);
        rom_data(CONV_INTEGER(DMEM_buffer_address(5 downto 0)))<= WrtData(31 downto 16); -- 1211 wrt the MSB bits
    end if;
end if;
end process;

-- input start

process(inputRdy)
begin

if(rising_edge(inputRdy)) then 
    input_data_buf <= inputData;
end if;

--rom_data(52)<= inputData(15 downto 0);
--rom_data(53)<= inputData(31 downto 16); 
--rom_data(54)<= inputData(47 downto 32); 
--rom_data(55)<= inputData(63 downto 48); 
--rom_data(56)<= inputData(79 downto 64);     -- B (15:0)
--rom_data(57)<= inputData(95 downto 80);     -- B (31:16)
--rom_data(58)<= inputData(111 downto 96);    -- A (15:0)
--rom_data(59)<= inputData(127 downto 112);   -- A (31:16)

end process;

--input end

--RD_Buffer <= rom_data(CONV_INTEGER(DMEM_buffer_address)+1) & rom_data(CONV_INTEGER(DMEM_buffer_address));

Rd_enable_and_address <= Read_Enable & DMEM_buffer_address;

with Rd_enable_and_address select
RD_Input_Buffer <= x"0000" & input_data_buf(15 downto 0) when "11000000", -- 1214 read input DMEM[64] - input (15:0)
                   x"0000" & input_data_buf(31 downto 16) when "11000001",
                   x"0000" & input_data_buf(47 downto 32) when "11000010",
                   x"0000" & input_data_buf(63 downto 48) when "11000011",
                   x"0000" & input_data_buf(79 downto 64) when "11000100",
                   x"0000" & input_data_buf(95 downto 80) when "11000101",
                   x"0000" & input_data_buf(111 downto 96) when "11000110",
                   x"0000" & input_data_buf(127 downto 112) when "11000111",
                 x"ffffffff" when others;

with Read_Enable select
RD_Reg_Buffer <= x"0000" & rom_data(CONV_INTEGER(DMEM_buffer_address(5 downto 0))) when '1', -- 1211 read "0000 0000 0000 0000" & DMEM[addr]
                 x"ffffffff" when others;
                 
with Rd_enable_and_address(7 downto 6) select
                 RD_Buffer <= RD_Reg_Buffer when "10", -- read from reg
                              RD_Input_Buffer when "11", -- read from input
                              x"ffffffff" when others;
             
rom_data_out<=rom_data;

--ReadData<=RD_Buffer;  -- 1211 Original

with Read_Enable select
ReadData <= RD_Buffer when '1', -- 1211 Peixuan, only update ReadData when read_enable = 1
             x"ffffffff" when others;

END Behavioral;