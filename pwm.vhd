----------------------------------------------------------------------------------
-- Create Date: 12/03/2015 06:30:38 PM
-- Module Name: pwm - Behavioral
-- Project Name: LEDDimmer
-- Authors: Joseph Prachar, Thomas Franklin, Corey Saeda, Vivek Bhakta 
-- Description: Uses the intensity value to create a clock signal used to dim the
--              LED.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity pwm is
    Port ( clk : in STD_LOGIC;
           intensity : in STD_LOGIC_VECTOR (6 downto 0);
           led_clk : out STD_LOGIC);
end pwm;

architecture Behavioral of pwm is

    signal totalCount: integer :=1;
    signal divided_clk: std_logic :='1';
    
begin
    
    clock_div: process(clk) begin
        
        if RISING_EDGE(clk) then
            totalCount <= totalCount + 1;
            
            if (totalCount = 100) then
                divided_clk <= '1';
                totalCount <= 1;            
            elsif (totalCount > to_integer(unsigned(intensity))) then
                divided_clk <= '0';
            end if;           
        end if;
        led_clk <= divided_clk;
    end process clock_div;
       
end Behavioral;
