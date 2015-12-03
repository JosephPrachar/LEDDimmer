----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/23/2015 04:09:48 PM
-- Design Name: 
-- Module Name: Timer - Behavioral
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


entity timer is
    Port ( divided_clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           max_time : in STD_LOGIC_VECTOR (11 downto 0);
           seconds : out STD_LOGIC_VECTOR (11 downto 0));
end timer;

architecture Behavioral of timer is

    signal sec : std_logic_vector (11 downto 0) := "111111111111";
    
begin
    
    dec_seconds : process(reset, divided_clk) begin
        if RISING_EDGE(reset) then
            sec <= max_time;
            seconds <= max_time;
        end if;
        
        if RISING_EDGE(divided_clk) then
            
            if NOT (sec = x"000") then
                sec <= std_logic_vector(unsigned(sec) - 1);
            end if;
            
            seconds <= sec;
            
        end if;
        
    end process dec_seconds;

end Behavioral;
