--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:22:38 11/19/2018
-- Design Name:   
-- Module Name:   D:/AHD/AHD_Projects/Final_Project/Register_TestBench.vhd
-- Project Name:  Final_Project
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
 
ENTITY Register_TestBench IS
END Register_TestBench;
 
ARCHITECTURE behavior OF Register_TestBench IS 
 
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
         ReadData2 : OUT  std_logic_vector(31 downto 0);
         Reg0 : OUT  std_logic_vector(31 downto 0);
         Reg1 : OUT  std_logic_vector(31 downto 0);
         Reg2 : OUT  std_logic_vector(31 downto 0);
         Reg3 : OUT  std_logic_vector(31 downto 0);
         Reg4 : OUT  std_logic_vector(31 downto 0);
         Reg5 : OUT  std_logic_vector(31 downto 0);
         Reg6 : OUT  std_logic_vector(31 downto 0);
         Reg7 : OUT  std_logic_vector(31 downto 0);
         Reg8 : OUT  std_logic_vector(31 downto 0);
         Reg9 : OUT  std_logic_vector(31 downto 0);
         Reg10 : OUT  std_logic_vector(31 downto 0);
         Reg11 : OUT  std_logic_vector(31 downto 0);
         Reg12 : OUT  std_logic_vector(31 downto 0);
         Reg13 : OUT  std_logic_vector(31 downto 0);
         Reg14 : OUT  std_logic_vector(31 downto 0);
         Reg15 : OUT  std_logic_vector(31 downto 0);
         Reg16 : OUT  std_logic_vector(31 downto 0);
         Reg17 : OUT  std_logic_vector(31 downto 0);
         Reg18 : OUT  std_logic_vector(31 downto 0);
         Reg19 : OUT  std_logic_vector(31 downto 0);
         Reg20 : OUT  std_logic_vector(31 downto 0);
         Reg21 : OUT  std_logic_vector(31 downto 0);
         Reg22 : OUT  std_logic_vector(31 downto 0);
         Reg23 : OUT  std_logic_vector(31 downto 0);
         Reg24 : OUT  std_logic_vector(31 downto 0);
         Reg25 : OUT  std_logic_vector(31 downto 0);
         Reg26 : OUT  std_logic_vector(31 downto 0);
         Reg27 : OUT  std_logic_vector(31 downto 0);
         Reg28 : OUT  std_logic_vector(31 downto 0);
         Reg29 : OUT  std_logic_vector(31 downto 0);
         Reg30 : OUT  std_logic_vector(31 downto 0);
         Reg31 : OUT  std_logic_vector(31 downto 0)
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
   signal Reg0 : std_logic_vector(31 downto 0);
   signal Reg1 : std_logic_vector(31 downto 0);
   signal Reg2 : std_logic_vector(31 downto 0);
   signal Reg3 : std_logic_vector(31 downto 0);
   signal Reg4 : std_logic_vector(31 downto 0);
   signal Reg5 : std_logic_vector(31 downto 0);
   signal Reg6 : std_logic_vector(31 downto 0);
   signal Reg7 : std_logic_vector(31 downto 0);
   signal Reg8 : std_logic_vector(31 downto 0);
   signal Reg9 : std_logic_vector(31 downto 0);
   signal Reg10 : std_logic_vector(31 downto 0);
   signal Reg11 : std_logic_vector(31 downto 0);
   signal Reg12 : std_logic_vector(31 downto 0);
   signal Reg13 : std_logic_vector(31 downto 0);
   signal Reg14 : std_logic_vector(31 downto 0);
   signal Reg15 : std_logic_vector(31 downto 0);
   signal Reg16 : std_logic_vector(31 downto 0);
   signal Reg17 : std_logic_vector(31 downto 0);
   signal Reg18 : std_logic_vector(31 downto 0);
   signal Reg19 : std_logic_vector(31 downto 0);
   signal Reg20 : std_logic_vector(31 downto 0);
   signal Reg21 : std_logic_vector(31 downto 0);
   signal Reg22 : std_logic_vector(31 downto 0);
   signal Reg23 : std_logic_vector(31 downto 0);
   signal Reg24 : std_logic_vector(31 downto 0);
   signal Reg25 : std_logic_vector(31 downto 0);
   signal Reg26 : std_logic_vector(31 downto 0);
   signal Reg27 : std_logic_vector(31 downto 0);
   signal Reg28 : std_logic_vector(31 downto 0);
   signal Reg29 : std_logic_vector(31 downto 0);
   signal Reg30 : std_logic_vector(31 downto 0);
   signal Reg31 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
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
          ReadData2 => ReadData2,
          Reg0 => Reg0,
          Reg1 => Reg1,
          Reg2 => Reg2,
          Reg3 => Reg3,
          Reg4 => Reg4,
          Reg5 => Reg5,
          Reg6 => Reg6,
          Reg7 => Reg7,
          Reg8 => Reg8,
          Reg9 => Reg9,
          Reg10 => Reg10,
          Reg11 => Reg11,
          Reg12 => Reg12,
          Reg13 => Reg13,
          Reg14 => Reg14,
          Reg15 => Reg15,
          Reg16 => Reg16,
          Reg17 => Reg17,
          Reg18 => Reg18,
          Reg19 => Reg19,
          Reg20 => Reg20,
          Reg21 => Reg21,
          Reg22 => Reg22,
          Reg23 => Reg23,
          Reg24 => Reg24,
          Reg25 => Reg25,
          Reg26 => Reg26,
          Reg27 => Reg27,
          Reg28 => Reg28,
          Reg29 => Reg29,
          Reg30 => Reg30,
          Reg31 => Reg31
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

      wait for clk_period*2;

      -- insert stimulus here 

		-- INSERT DATA TO REGISTER 1
		WrtEnable	<= '1';
		RReg1 <= (others => '0');
		RReg2 <= (others => '0');
		WrtReg <= "00001";
		WrtData 	<= (others => '1');

		wait for CLK_period*2;

		-- READ DATA FROM REGISTER 1
		WrtEnable	<= '0';
		RReg1 <= "00001";
		RReg2 <= "00001";
		WrtReg <= (others => '0');
		WrtData 	<= (others => '0');
      wait;
   end process;

END;
