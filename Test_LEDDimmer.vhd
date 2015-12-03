----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2015 06:42:52 PM
-- Design Name: 
-- Module Name: Test_LEDDimmer - Behavioral
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

entity Test_LEDDimmer is
--  Port ( );
end Test_LEDDimmer;

architecture Behavioral of Test_LEDDimmer is
    component LEDDimmer Port ( CLK : in STD_LOGIC;
           LightSwitch : in STD_LOGIC_VECTOR (2 downto 0);
           Refresh : in STD_LOGIC;
           Disp_En : out STD_LOGIC_VECTOR (3 downto 0);
           Disp_Segments : out STD_LOGIC_VECTOR (8 downto 0);
           LED : out STD_LOGIC);
    end component;
    
    signal CLK, Refresh: STD_LOGIC;
    signal ls: STD_LOGIC_VECTOR (2 downto 0);
    signal led: STD_LOGIC;
begin
    dimmer: LEDDimmer PORT MAP (CLK, ls, Refresh, open, open, led);
    
    clkDriver: process
    begin
        CLK <= '0';
        wait for 1 ns;
        CLK <= '1';
        wait for 1 ns;
    end process;

    test: process
    begin
        Refresh <= '0';
        ls <= "000";
        wait for 100 ns;
        
        ls <= "001";
        wait for 110 sec;
    end process;

end Behavioral;
