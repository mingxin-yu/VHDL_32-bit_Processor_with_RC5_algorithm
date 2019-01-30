--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:31:22 11/18/2018
-- Design Name:   
-- Module Name:   C:/ISE/Project_1/Reister_tb.vhd
-- Project Name:  Project_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: register_file_VHDL
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
 
ENTITY Reister_tb IS
END Reister_tb;
 
ARCHITECTURE behavior OF Reister_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT register_file_VHDL
    PORT(
         clk : IN  std_logic;
         WrtEnable : IN  std_logic;
         WrtReg : IN  std_logic_vector(4 downto 0);
         WrtData : IN  std_logic_vector(31 downto 0);
         RReg1 : IN  std_logic_vector(4 downto 0);
         RReg2 : IN  std_logic_vector(4 downto 0);
         ReadData1 : OUT  std_logic_vector(31 downto 0);
         ReadData2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal WrtEnable : std_logic := '0';
   signal WrtReg : std_logic_vector(4 downto 0) := (others => '0');
   signal WrtData : std_logic_vector(31 downto 0) := (others => '0');
   signal RReg1 : std_logic_vector(4 downto 0) := (others => '0');
   signal RReg2 : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal ReadData1 : std_logic_vector(31 downto 0);
   signal ReadData2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: register_file_VHDL PORT MAP (
          clk => clk,
          WrtEnable => WrtEnable,
          WrtReg => WrtReg,
          WrtData => WrtData,
          RReg1 => RReg1,
          RReg2 => RReg2,
          ReadData1 => ReadData1,
          ReadData2 => ReadData2
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

      wait for clk_period*10;

      -- insert stimulus here 

		-- INSERT DATA TO REGISTER 1
		WrtEnable	<= '1';
		RReg1 <= (others => '0');
		RReg2 <= (others => '0');
		WrtReg <= "00001";
		WrtData 	<= (others => '1');

		wait for CLK_period*10;

		-- READ DATA FROM REGISTER 1
		WrtEnable	<= '0';
		RReg1 <= "00001";
		RReg2 <= "00001";
		WrtReg <= (others => '0');
		WrtData 	<= (others => '0');

      wait;
   end process;

END;
