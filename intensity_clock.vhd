----------------------------------------------------------------------------------
-- Create Date: 12/01/2015 10:54:36 AM
-- Module Name: intensity_clock_divider - Behavioral
-- Project Name: LEDDimmer
-- Authors: Joseph Prachar, Thomas Franklin, Corey Saeda, Vivek Bhakta 
-- Description: Divides the board's clock into intervals at which the LED should
--              be dimmed by 1%
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity intensity_clock_divider is
    Port ( second_clock : in STD_LOGIC;
           rate_of_change : in STD_LOGIC_VECTOR (5 downto 0);
           intensity_clock : out STD_LOGIC);
end intensity_clock_divider;

architecture Behavioral of intensity_clock_divider is

    signal count : integer :=1;
    signal divided_clk: std_logic;
    signal rate_of_change_half : std_logic_vector (5 downto 0);
    
begin

     clock_div: process(second_clock) begin
        
        if (rate_of_change = "000001") then
            intensity_clock <= second_clock;
            count <= 1;
            
        elsif RISING_EDGE(second_clock) then
            count <= count + 1;
            rate_of_change_half <= std_logic_vector(unsigned(rate_of_change) / 2);

            if (std_logic_vector(to_unsigned(count,5)) = rate_of_change_half) then
                divided_clk <= NOT divided_clk;
                count <= 1;
                intensity_clock <= divided_clk;
                
            end if;
            
        end if;
    
    end process clock_div;

end Behavioral;
