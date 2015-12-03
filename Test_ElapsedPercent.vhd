----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2015 03:30:09 PM
-- Design Name: 
-- Module Name: Test_ElapsedPercent - Behavioral
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
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Test_ElapsedPercent is
--  Port ( );
end Test_ElapsedPercent;

architecture Behavioral of Test_ElapsedPercent is
    component ElapsedPercent Port ( TotalTime : in STD_LOGIC_VECTOR (11 downto 0);
       CurrentTime : in STD_LOGIC_VECTOR (11 downto 0);
       PercentToCheck : in STD_LOGIC_VECTOR (6 downto 0);
       BelowThreshold : out STD_LOGIC);
    end component;
    
    signal s_TotalTime, s_CurrentTime: STD_LOGIC_VECTOR (11 downto 0);
    signal below20, below50: STD_LOGIC := '0';
begin
    elapsed20: ElapsedPercent PORT MAP (s_TotalTime, s_CurrentTime, "0010100", Below20);
    elapsed50: ElapsedPercent PORT MAP (s_TotalTime, s_CurrentTime, "0110010", Below50);
    
    test: process
    begin
        s_TotalTime <= "011100001000"; -- 1800
        s_CurrentTime <= "011100001000"; -- 1800
        wait for 10 ns;
        
        s_CurrentTime <= "001111101000"; -- 1000
        wait for 10 ns;
        
        s_CurrentTime <= "001100100000"; -- 800
        wait for 10 ns;
        
        s_CurrentTime <= "000100101100"; -- 300
        wait;
    end process;

end Behavioral;
