-- GPX 12142018 backup
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use work.MyType.all;

entity FPGA_MIPS_Processor is
Port ( 
       CPU_RESETN:    in  STD_LOGIC;
       SW:           in STD_LOGIC_VECTOR(15 DOWNTO 0);
       BTNC             : in  STD_LOGIC;
       BTNU            : in  STD_LOGIC;
       BTNR            : in  STD_LOGIC; -- 1214
       CLK             : in  STD_LOGIC;
       LED             : out STD_LOGIC_VECTOR(15 DOWNTO 0);
       SSEG_CA         : out  STD_LOGIC_VECTOR (7 downto 0);
       SSEG_AN         : out  STD_LOGIC_VECTOR (7 downto 0)
        );
end FPGA_MIPS_Processor;

architecture Behavioral of FPGA_MIPS_Processor is

component clock_divider
    Port ( 
       CLK             : in  STD_LOGIC;
       divider_CLK         : out  STD_LOGIC
        );
end component;

component SevenSeg_top
Port ( 
CLK             : in  STD_LOGIC;
input           : in  STD_LOGIC_VECTOR (31 downto 0);
SSEG_CA         : out  STD_LOGIC_VECTOR (7 downto 0);
SSEG_AN         : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal realCLK : STD_LOGIC;
signal realLED : STD_LOGIC_VECTOR(31 downto 0);
signal CA,AN : STD_LOGIC_VECTOR(63 downto 0); 
signal Global_clr: STD_LOGIC;

component MIPS_Processor
Port ( clk : in  STD_LOGIC;
       reset : in  STD_LOGIC;
       
       inputData: in  std_logic_vector(127 downto 0); -- input data
       inputRdy: in std_logic;
       mode_select: IN std_logic_vector(1 downto 0);
       
       current_PC : out  STD_LOGIC_VECTOR (31 downto 0);
       current_Inst : out  STD_LOGIC_VECTOR (31 downto 0);
       rom_data_out: out MEM;
       reg_data:out REG
       );
end component;

component input_devider 
PORT (SW_1: in STD_LOGIC;
      reset:  in STD_LOGIC;
      switch: in STD_LOGIC_VECTOR(7 DOWNTO 0);
      i_cnt: out STD_LOGIC_VECTOR(4 DOWNTO 0);
      B_output: out STD_LOGIC_VECTOR(127 DOWNTO 0);
      ready: out STD_LOGIC
      );
end component;

signal inputDataSig: std_logic_vector(127 downto 0); -- input data
signal inputRdySig: std_logic;

signal inputSeg: std_logic_vector(4 downto 0);
signal inputDisplay: std_logic_vector(31 downto 0);

signal inputDebug: std_logic_vector(127 downto 0); -- input data debug
--signal inputZero: std_logic_vector(127 downto 0) := x"123456789AB0CDEF1122334455667788"; -- input data debug
signal inputZero: std_logic_vector(127 downto 0) := x"00000000000000000000000000000001"; -- input data debug

signal modeSel: std_logic_vector(1 downto 0); -- input data debug

signal register_content : STD_LOGIC_VECTOR(31 downto 0); 
signal PC : STD_LOGIC_VECTOR(31 downto 0);
signal Inst : STD_LOGIC_VECTOR(31 downto 0);


--signal real_CLK : STD_LOGIC;
signal fast_clk : STD_LOGIC; -- 120222018 slow clk
signal sys_clk : STD_LOGIC; -- 120222018 slow clk
signal rom_data: MEM;
signal reg_array: REG;
signal haltHexval:STD_LOGIC_VECTOR(31 downto 0);

begin
clk_dev: clock_divider PORT MAP(CLK => CLK, divider_CLK => fast_clk);

with btnC select
sys_clk <= btnU when '0',
           fast_clk when others;


Global_clr<= not CPU_RESETN;

Inst_MIPS_Processor: MIPS_Processor PORT MAP(
       --clk => SW(0),
       clk => sys_clk,
       reset => Global_clr,
       
       inputData => inputDataSig, -- input data
       --inputData => inputZero, -- input data
       inputRdy => inputRdySig,
       mode_select => modeSel,
       
       current_PC => PC,
       current_Inst => Inst,
       rom_data_out=>rom_data,
       reg_data=>reg_array
	);
	
	
Inst_input_devider: input_devider PORT MAP (
          --SW_1 => sw(12),
          SW_1 => BTNR,
          reset => sw(13),
          switch => sw(7 downto 0),
          i_cnt => inputSeg,
          B_output => inputDataSig,
          ready => inputRdySig
          );



with sw(11 downto 10) select           --No worry about the usage of sw here; when in input stage(pc count=0), the halt Hexval won't be displayed anyway
  haltHexval <=   Inst when "00",
                  rom_data(conv_integer(sw(6 downto 0)))&rom_data(conv_integer(sw(6 downto 0))+1)  when "01",
                  PC  when "10",   --Current Instruction
                  reg_array(conv_integer(sw(4 downto 0))) when others;


seven_seg: SevenSeg_Top PORT MAP(realCLK, haltHexval ,CA(7 downto 0),AN(7 downto 0));

realCLK <= CLK;

modeSel <= sw(15 downto 14);

SSEG_CA(7 downto 0) <= CA(7 downto 0);
SSEG_AN(7 downto 0) <= AN(7 downto 0);

LED(15 downto 5) <= "00000000000";
LED(4) <= inputRdySig;
Led(3 downto 0) <= inputSeg(3 downto 0);

end Behavioral;
