----------------------------------------------------------------------------------
-- Create Date: 12/01/2015 11:21:10 AM
-- Module Name: DetectChange - Behavioral
-- Project Name: LEDDimmer
-- Authors: Joseph Prachar, Thomas Franklin, Corey Saeda, Vivek Bhakta 
-- Description: Detects if the switches have changed or the button has been pressed
--              and creates a reset signal
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DetectChange is
    Port ( Clk : in STD_LOGIC;
           LightSwitch_in : in STD_LOGIC_VECTOR (2 downto 0);
           LightSwitch_out : out STD_LOGIC_VECTOR (2 downto 0);
           Change : out STD_LOGIC);
end DetectChange;

architecture Behavioral of DetectChange is
    signal LightSwitch_last : STD_LOGIC_VECTOR (2 downto 0);
begin
    LightSwitch_out <= LightSwitch_last;
    main: process(Clk)
    begin
        if (rising_edge(Clk)) then
            if (LightSwitch_in /= LightSwitch_last) then
                Change <= '1';
            else
                Change <= '0';
            end if;
            LightSwitch_last <= LightSwitch_in;
        end if;
    end process;

end Behavioral;
