--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:36:24 11/24/2018
-- Design Name:   
-- Module Name:   D:/AHD/AHD_Projects/Final_Project/DMEM_TB.vhd
-- Project Name:  Final_Project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DMEM
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
 
ENTITY DMEM_TB IS
END DMEM_TB;
 
ARCHITECTURE behavior OF DMEM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DMEM
    PORT(
         clk : IN  std_logic;
         Wrt_Enable : IN  std_logic;
         Read_Enable : IN  std_logic;
         Address : IN  std_logic_vector(31 downto 0);
         WrtData : IN  std_logic_vector(31 downto 0);
         ReadData : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal Wrt_Enable : std_logic := '0';
   signal Read_Enable : std_logic := '0';
   signal Address : std_logic_vector(31 downto 0) := (others => '0');
   signal WrtData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal ReadData : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1000 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DMEM PORT MAP (
          clk => clk,
          Wrt_Enable => Wrt_Enable,
          Read_Enable => Read_Enable,
          Address => Address,
          WrtData => WrtData,
          ReadData => ReadData
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
      wait for 100 ns;
		
		wait for clk_period*5;
		Wrt_Enable <= '1';
		Address <= x"00000006";
		--WrtData <= x"0000000a";
		wait for clk_period/2;
		WrtData <= x"01abcdef";
		wait for clk_period/2;
		Wrt_Enable <= '0';
		Read_Enable <= '1';
		Address <= x"0000000c";
		wait for clk_period;
		Read_Enable <= '0';
		Address <= x"00000000";
		WrtData <= x"00000000";
		
		wait for clk_period;
		Wrt_Enable <= '0';
		Read_Enable <= '1';
		Address <= x"0000000c";
		wait for clk_period;
		Read_Enable <= '0';
		Address <= x"00000000";
		WrtData <= x"00000000";
		

      -- insert stimulus here 

      wait;
   end process;

END;
