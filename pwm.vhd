----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2015 06:30:38 PM
-- Design Name: 
-- Module Name: pwm - Behavioral
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
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
