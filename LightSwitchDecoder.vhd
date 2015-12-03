----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2015 10:44:16 AM
-- Design Name: 
-- Module Name: LightSwitchDecoder - Behavioral
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

entity LightSwitchDecoder is
    Port ( LightSwitch : in STD_LOGIC_VECTOR (2 downto 0);
           TimeOut : out STD_LOGIC_VECTOR (11 downto 0));
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
end Behavioral;
