--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:43:40 11/18/2018
-- Design Name:   
-- Module Name:   D:/AHD/AHD_Projects/Final_Project/MIPS_Processor_TestBench.vhd
-- Project Name:  Final_Project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MIPS_Processor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.MyType.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MIPS_Processor_TestBench IS
END MIPS_Processor_TestBench;
 
ARCHITECTURE behavior OF MIPS_Processor_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MIPS_Processor
    PORT(
	    clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        inputData: in  std_logic_vector(127 downto 0); -- input data
        inputRdy: in std_logic;
        mode_select: IN std_logic_vector(1 downto 0);
        current_PC : out  STD_LOGIC_VECTOR (31 downto 0);
        current_Inst : out  STD_LOGIC_VECTOR (31 downto 0);
        rom_data_out: out MEM;
        reg_data:out REG
        );
    END COMPONENT;
    
    signal inputData:  std_logic_vector(127 downto 0):=(others=>'0'); -- input data
    signal inputRdy: std_logic:='0';
    signal mode_select: std_logic_vector(1 downto 0) := "00";
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal current_PC : std_logic_vector(31 downto 0);
   signal current_Inst : std_logic_vector(31 downto 0);
   signal rom_data_out: MEM;
   signal reg_data:REG;

   -- Clock period definitions
   constant clk_period : time := 1 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MIPS_Processor PORT MAP (
          clk => clk,
          reset => reset,
          inputData => inputData, -- input data
          inputRdy => inputRdy,
          mode_select => mode_select,
          current_PC => current_PC,
          current_Inst => current_Inst,
          rom_data_out => rom_data_out,
          reg_data => reg_data
        );

   -- Clock process definitions
   clk_process :process
   begin
		--clk <= '0';
		--wait for clk_period/2;
		--clk <= '1';
		--wait for clk_period/2;
		
		-- 11252018 night
		clk <= '1';
        wait for clk_period/2;
        clk <= '0';
        wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      inputRdy <= '0';
      --inputData <= x"38383838383838383838383838383838";
      --inputData <= x"00000000000000000000000000000001";
       inputData <= x"3E0C97BEADA501D17C5E1CAD016EC5E7";
      wait for 2 us;
        mode_select <= "00";
		inputRdy <= '1';
		reset <= '1';
      wait for 2 us;
         inputData <= (others => '0');
        inputRdy <= '0';
		reset <='0';
		wait for 500 us;           -- input mode
		
		mode_select <= "11";
        reset <= '1';
        wait for 2 us;
        reset <= '0';
        wait for 20000 us;        -- Key Gen
        
        inputRdy <= '0';
        --inputData <= x"0f0f0f0f0f0f0f0f0000000000000000";
        --inputData <= x"00000000000000000000000000000000";
        inputData <= x"E265973B3A38A71C0000000000000000";
        wait for 2 us;
        mode_select <= "00";
        inputRdy <= '1';
        reset <= '1';
        wait for 2 us;
        inputData <= (others => '0');
        inputRdy <= '0';
        reset <='0';
        wait for 500 us;           -- Input
        
        mode_select <= "01";
        reset <= '1';
        wait for 2 us;
        reset <= '0';
        wait for 20000 us;        -- Encode
        
        inputRdy <= '0';
        --inputData <= x"0f0f0f0f0f0f0f0f0000000000000000";
        --inputData <= x"00000000000000000000000000000000";
        inputData <= x"E265973B3A38A71C0000000000000000";
        wait for 2 us;
        mode_select <= "00";
        inputRdy <= '1';
        reset <= '1';
        wait for 2 us;
        inputData <= (others => '0');
        inputRdy <= '0';
        reset <='0';
        wait for 500 us;           -- Input
        
        mode_select <= "10";
        reset <= '1';
        wait for 2 us;
        reset <= '0';
        wait for 20000 us;        -- Decode
        
		

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
