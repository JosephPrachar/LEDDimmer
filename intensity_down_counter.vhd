----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2015 12:40:35 PM
-- Design Name: 
-- Module Name: intensity_down_counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;


entity intensity_down_counter is
    Port ( intensity_clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           set_to_half : in STD_LOGIC;
           set_to_zero : in STD_LOGIC;
           intensity : out STD_LOGIC_VECTOR (6 downto 0));
end intensity_down_counter;

architecture Behavioral of intensity_down_counter is

    signal current_intensity : integer :=100;
    signal counting : std_logic :='0';

begin

    determine_intensity: process(reset, set_to_half, set_to_zero, intensity_clk) begin
    
        if (reset = '1') then
            current_intensity <= 100;
            counting <= '0';
            
        elsif(set_to_half = '1') then 
            current_intensity <= 50;
            counting <= '1';
            
        elsif(set_to_zero = '1') then
            current_intensity <= 0;
            counting <= '0';
            
        elsif((counting = '1') AND RISING_EDGE(intensity_clk)) then
            current_intensity <= current_intensity - 1;
            
        end if;
        
        intensity <= std_logic_vector(to_unsigned(current_intensity, 7));
    
    end process determine_intensity;
        
end Behavioral;
