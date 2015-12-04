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

    signal count : integer :=1;
    signal divided_clk: std_logic :='0';
    
begin
    
    clock_div: process(clk) begin
        
        if RISING_EDGE(clk) then
            count <= count + 1;
            
            if (divided_clk = '0') AND (count = 100) then
                count <= 1;
                divided_clk <= '1';
                led_clk <= divided_clk;
            elsif (divided_clk = '1') AND (count = to_integer(unsigned(intensity))) then
                count <= 1;
                divided_clk <= '0';
                led_clk <= divided_clk;
                
            end if;
           
        end if;
        
    end process clock_div;
       
end Behavioral;
