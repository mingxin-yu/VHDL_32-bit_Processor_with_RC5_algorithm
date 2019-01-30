--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:25:58 11/19/2018
-- Design Name:   
-- Module Name:   D:/AHD/AHD_Projects/Final_Project/MIPS_Processor_TB.vhd
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MIPS_Processor_TB IS
END MIPS_Processor_TB;
 use work.MyType.all;
 
ARCHITECTURE behavior OF MIPS_Processor_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MIPS_Processor
    PORT(
			  clk : in  STD_LOGIC;
 reset : in  STD_LOGIC;
 current_PC : out  STD_LOGIC_VECTOR (31 downto 0);
 current_Inst : out  STD_LOGIC_VECTOR (31 downto 0);
 rom_data_out: out MEM;
 reg_data:out REG
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
    
   signal rom: MEM;
   signal reg: REG; 

   signal current_PC : std_logic_vector(31 downto 0);
   signal current_Inst : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MIPS_Processor PORT MAP (
          clk => clk,
          reset => reset,
          current_PC => current_PC,
          current_Inst => current_Inst,
          rom_data_out=>rom,
          reg_data=>reg
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '1';
      wait for 200 ns;
		reset <='0';

      wait for clk_period*20;

      -- insert stimulus here 

      wait;
   end process;

END;
