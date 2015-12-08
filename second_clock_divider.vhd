----------------------------------------------------------------------------------
-- Create Date: 12/01/2015 10:41:16 AM
-- Module Name: second_clock_divider - Behavioral
-- Project Name: LEDDimmer
-- Authors: Joseph Prachar, Thomas Franklin, Corey Saeda, Vivek Bhakta 
-- Description: Divides the board's clock into seconds
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity second_clock_divider is
    Port ( old_clock : in STD_LOGIC;
           new_clock : out STD_LOGIC);
end second_clock_divider;

architecture Behavioral of second_clock_divider is 

    signal count : integer :=1;
    signal divided_clk: std_logic :='0';
    
begin

    clock_div: process(old_clock) begin
    
        if RISING_EDGE(old_clock) then
            count <= count + 1;
            
            if (count = 50000000) then
                divided_clk <= NOT divided_clk;
                count <= 1;
                new_clock <= divided_clk;
                
            end if;
            
        end if;
    
    end process clock_div;

end Behavioral;
