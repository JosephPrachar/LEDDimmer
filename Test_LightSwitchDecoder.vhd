----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2015 10:52:38 AM
-- Design Name: 
-- Module Name: Test_LightSwitchDecoder - Behavioral
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

entity Test_LightSwitchDecoder is
--  Port ( );
end Test_LightSwitchDecoder;

architecture Behavioral of Test_LightSwitchDecoder is
    component LightSwitchDecoder Port 
       (LightSwitch : in STD_LOGIC_VECTOR (2 downto 0);
        TimeOut : out STD_LOGIC_VECTOR (11 downto 0));
    end component;
    
    signal s_Switches : STD_LOGIC_VECTOR (2 downto 0);
    signal s_Time : STD_LOGIC_VECTOR (11 downto 0);
begin
    decoder: LightSwitchDecoder PORT MAP (s_Switches, s_Time);
    
    test: process
    begin
        s_Switches <= "000";
        wait for 10 ns;
        assert to_integer(unsigned(s_Time)) = 0 report "0 broken" severity ERROR;
        
        s_Switches <= "001";
        wait for 10 ns;
        assert to_integer(unsigned(s_Time)) = 100 report "1 broken" severity ERROR;
        
        s_Switches <= "010";
        wait for 10 ns;
        assert to_integer(unsigned(s_Time)) = 600 report "2 broken" severity ERROR;
        
        s_Switches <= "011";
        wait for 10 ns;
        assert to_integer(unsigned(s_Time)) = 1200 report "3 broken" severity ERROR;
        
        s_Switches <= "100";
        wait for 10 ns;
        assert to_integer(unsigned(s_Time)) = 1800 report "4 broken" severity ERROR;
        
        s_Switches <= "101";
        wait for 10 ns;
        assert to_integer(unsigned(s_Time)) = 2400 report "5 broken" severity ERROR;
        
        s_Switches <= "110";
        wait for 10 ns;
        assert to_integer(unsigned(s_Time)) = 3000 report "6 broken" severity ERROR;
        
        s_Switches <= "111";
        wait for 10 ns;
        assert to_integer(unsigned(s_Time)) = 3600 report "7 broken" severity ERROR;
    end process;
end Behavioral;
