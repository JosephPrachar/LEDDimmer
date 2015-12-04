----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2015 09:48:04 PM
-- Design Name: 
-- Module Name: Test_PWM - Behavioral
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

entity Test_PWM is
--  Port ( );
end Test_PWM;

architecture Behavioral of Test_PWM is
    component pwm Port ( clk : in STD_LOGIC;
           intensity : in STD_LOGIC_VECTOR (6 downto 0);
           led_clk : out STD_LOGIC);
    end component;
    
    signal s_clk, s_led: STD_LOGIC;
    signal s_intensity: STD_LOGIC_VECTOR (6 downto 0);
begin
    module: pwm PORT MAP (s_clk, s_intensity, s_led);

    clkDriver: process
    begin
        s_clk <= '0';
        wait for 1 ns;
        s_clk <= '1';
        wait for 1 ns;
    end process;
    
    test: process
    begin
        s_intensity <= "0000000"; -- 100
        wait for 500 ns;
        
        s_intensity <= "0110100"; -- 50
        wait for 500 ns;
        
        s_intensity <= "0010000"; -- 16
        wait for 600 ns;
    
    end process;

end Behavioral;
