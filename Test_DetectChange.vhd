----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2015 11:28:41 AM
-- Design Name: 
-- Module Name: Test_DetectChange - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Test_DetectChange is
--  Port ( );
end Test_DetectChange;

architecture Behavioral of Test_DetectChange is
    component DetectChange Port ( Clk : in STD_LOGIC;
       LightSwitch_in : in STD_LOGIC_VECTOR (2 downto 0);
       LightSwitch_out : out STD_LOGIC_VECTOR (2 downto 0);
       Change : out STD_LOGIC);
    end component;
    
    signal s_clk: STD_LOGIC;
    signal s_change: STD_LOGIC;
    signal s_switch_in, s_switch_out: STD_LOGIC_VECTOR (2 downto 0);
begin
    detect: DetectChange PORT MAP (s_clk, s_switch_in, s_switch_out, s_change);
    
    runClk: process
    begin
        s_clk <= '0';
        wait for 1 ns;
        s_clk <= '1';
        wait for 1 ns;
    end process;

    test: process
    begin
        s_switch_in <= "000";
        wait for 20 ns;
        
        s_switch_in <= "010";
        wait for 20 ns;
        
        s_switch_in <= "100";
        wait for 20 ns;
        
        s_switch_in <= "000";
        wait for 20 ns;
    end process;

end Behavioral;
