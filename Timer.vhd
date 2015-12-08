----------------------------------------------------------------------------------
-- Create Date: 11/23/2015 04:09:48 PM
-- Module Name: Timer - Behavioral
-- Project Name: LEDDimmer
-- Authors: Joseph Prachar, Thomas Franklin, Corey Saeda, Vivek Bhakta 
-- Description: Counts down in seconds from the user set time
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
    signal sec : std_logic_vector (11 downto 0) := "000000000000";
    
begin
    
    dec_seconds : process(reset, divided_clk) begin
        
        if (reset = '1') then
            sec <= max_time;
            seconds <= max_time;  
        elsif RISING_EDGE(divided_clk) then
            if NOT (sec = x"000") then
                sec <= std_logic_vector(unsigned(sec) - 1);
            end if;
            
            seconds <= sec;
            
        end if;
        
    end process dec_seconds;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity resetMod is
    Port ( clk : in STD_LOGIC;
           reset_in : in STD_LOGIC;
           reset_out : out STD_LOGIC);
end resetMod;

architecture Behavioral1 of resetMod is
    signal count: STD_LOGIC := '0';
begin

    res: process (clk)
    begin
        if reset_in = '1' then
            if (count = '0') then
                reset_out <= '1';
                count <= '1';
            else
                reset_out <= '0';
            end if;
        else
            count <= '0';
        end if;
    end process;

end Behavioral1;