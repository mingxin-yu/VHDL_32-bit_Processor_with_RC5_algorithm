--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:09:46 11/18/2018
-- Design Name:   
-- Module Name:   D:/AHD/AHD_Projects/Final_Project/PC_TestBench.vhd
-- Project Name:  Final_Project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PC
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
 
ENTITY PC_TestBench IS
END PC_TestBench;
 
ARCHITECTURE behavior OF PC_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PC
    PORT(
         clk : IN  std_logic;
			reset: in STD_LOGIC;
         PC_input : IN  std_logic_vector(31 downto 0);
         PC_output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	signal reset : std_logic := '0';
   signal PC_input : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal PC_output : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PC PORT MAP (
          clk => clk,
			 reset => reset,
          PC_input => PC_input,
          PC_output => PC_output
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
      wait for 115 ns;	
		PC_input <= x"00000001";
		wait for 100 ns;	
		PC_input <= x"00000002";
		wait for 100 ns;	
		PC_input <= x"00000003";
		wait for 100 ns;	
		PC_input <= x"00000004";
		wait for 100 ns;	
		PC_input <= x"00000005";
		wait for 25 ns;
		reset <= '1';
		wait for 100 ns;
		reset <= '0';
		PC_input <= x"00000001";

      -- insert stimulus here 

      wait;
   end process;

END;
