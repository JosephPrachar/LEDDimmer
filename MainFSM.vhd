----------------------------------------------------------------------------------
-- Create Date: 11/30/2015 12:17:46 PM
-- Module Name: MainFSM - Behavioral
-- Project Name: LEDDimmer
-- Authors: Joseph Prachar, Thomas Franklin, Corey Saeda, Vivek Bhakta 
-- Description: Main FSM to control the intensity counter
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MainFSM is
    Port ( Off : in STD_LOGIC;
           Clk : in STD_LOGIC;
           TimeAt20 : in STD_LOGIC;
           TimeAt50 : in STD_LOGIC;
           Clk_Intensity : in STD_LOGIC;
           Refresh : in STD_LOGIC;
           IntensityDown : out STD_LOGIC;
           ResetTime : out STD_LOGIC;
           Set50 : out STD_LOGIC;
           Set0 : out STD_LOGIC);
end MainFSM;

architecture Behavioral of MainFSM is

    type state_type is (off_state, on_state, dimming);
    signal currentState : state_type := on_state;
    signal nextState: state_type;
begin

    advance_state : process(Clk, refresh)
    begin
        if (refresh = '1') then
            nextState <= on_state;
        elsif (off = '1') then
            nextState <= off_state;
        elsif rising_edge(Clk) then
            case currentState is 
                when on_state =>
                    if TimeAt50 = '1' then
                        nextState <= dimming;
                    end if;
                when dimming =>
                    if TimeAt20 = '1' then
                        nextState <= off_state;
                    end if;
                when others =>
                    null;
            end case;
        end if;
        currentState <= nextState;
    end process;
    
    output_process: process(currentState, Clk_Intensity)
    begin
        case currentState is 
            when off_state =>
                ResetTime <= '0';
                Set50 <= '0';
                Set0 <= '1';
            when on_state =>
                ResetTime <= '1';
                Set50 <= '0';
                Set0 <= '0';
            when dimming =>
                ResetTime <= '0';
                Set50 <= '1';
                Set0 <= '0';
        end case;
        if currentState = dimming then
            IntensityDown <= Clk_Intensity;
        else
            IntensityDown <= '0';
        end if;
    end process;
end Behavioral;
