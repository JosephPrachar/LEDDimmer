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

    
    signal counting: std_logic:='0';

begin

    determine_intensity: process(reset, set_to_half, set_to_zero, intensity_clk) 
        variable current_intensity : std_logic_vector (6 downto 0):="0000000";
        
        begin
    
    
    if (rising_edge(intensity_clk)) then
        if (reset = '1') then
            current_intensity := "1100100";
            counting <= '0';
            
       elsif(set_to_zero = '1') then
                        current_intensity := "0000000";
                        counting <= '0';
            
        elsif((counting = '1')) then
            current_intensity := std_logic_vector( unsigned(current_intensity) - 1);
            counting <= '1';
            
        elsif(set_to_half = '1') then
            current_intensity := "0110010"; 
            counting <= '1';

            
        end if;
    end if;
        
        intensity <= current_intensity;
    
    end process determine_intensity;
        
        
end Behavioral;
