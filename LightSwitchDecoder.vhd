----------------------------------------------------------------------------------
-- Create Date: 12/01/2015 10:44:16 AM
-- Module Name: LightSwitchDecoder - Behavioral
-- Project Name: LEDDimmer
-- Authors: Joseph Prachar, Thomas Franklin, Corey Saeda, Vivek Bhakta 
-- Description: Decodes the bits from the switches into 8 different time settings
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LightSwitchDecoder is
    Port ( LightSwitch : in STD_LOGIC_VECTOR (2 downto 0);
           TimeOut : out STD_LOGIC_VECTOR (11 downto 0);
           RateOfChange : out STD_LOGIC_VECTOR (5 downto 0);
           Off : out STD_LOGIC);
end LightSwitchDecoder;

architecture Behavioral of LightSwitchDecoder is
begin
    TimeOut <= "000000000000" when LightSwitch = "000" else
        "000001100100" when LightSwitch = "001" else
        "001001011000" when LightSwitch = "010" else
        "010010110000" when LightSwitch = "011" else
        "011100001000" when LightSwitch = "100" else
        "100101100000" when LightSwitch = "101" else
        "101110111000" when LightSwitch = "110" else
        "111000010000" when LightSwitch = "111";
        
    RateOfChange <= "000000" when LightSwitch = "000" else
        "000001" when LightSwitch = "001" else
        "000110" when LightSwitch = "010" else
        "001100" when LightSwitch = "011" else
        "010010" when LightSwitch = "100" else
        "011000" when LightSwitch = "101" else
        "011110" when LightSwitch = "110" else
        "100100" when LightSwitch = "111";
        
    Off <= '1' when LightSwitch = "000" else '0';
end Behavioral;
