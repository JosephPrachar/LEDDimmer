----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2015 12:17:46 PM
-- Design Name: 
-- Module Name: MainFSM - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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

    type state_type is (off_state, reset, on_state, set_50, dimming, set_0);
    signal currentState : state_type;
    signal nextState: state_type;
begin

    advance_state : process(Clk, refresh)
    begin
        if (refresh = '1') then
            nextState <= reset;
        elsif (off = '1') then
            nextState <= off_state;
        elsif rising_edge(Clk) then
            case currentState is 
                when reset =>
                    nextState <= on_state;
                when on_state =>
                    if TimeAt50 = '1' then
                        nextState <= set_50;
                    end if;
                when set_50 =>
                    nextState <= dimming;
                when dimming =>
                    if TimeAt20 = '1' then
                        nextState <= set_0;
                    end if;
                when set_0 =>
                    nextState <= off_state;
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
                Set0 <= '0';
            when on_state =>
                ResetTime <= '0';
                Set50 <= '0';
                Set0 <= '0';
            when dimming =>
                ResetTime <= '0';
                Set50 <= '0';
                Set0 <= '0';
            when reset =>
                ResetTime <= '1';
                Set50 <= '0';
                Set0 <= '0';
            when set_50 =>
                ResetTime <= '0';
                Set50 <= '1';
                Set0 <= '0';
            when set_0 =>
                ResetTime <= '0';
                Set50 <= '0';
                Set0 <= '1';
        end case;
        if currentState = dimming then
            IntensityDown <= Clk_Intensity;
        else
            IntensityDown <= '0';
        end if;
    end process;
end Behavioral;
