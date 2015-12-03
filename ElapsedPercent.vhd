----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2015 03:14:52 PM
-- Design Name: 
-- Module Name: ElapsedPercent - Behavioral
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

entity ElapsedPercent is
    Port ( TotalTime : in STD_LOGIC_VECTOR (11 downto 0);
           CurrentTime : in STD_LOGIC_VECTOR (11 downto 0);
           PercentToCheck : in integer;
           BelowThreshold : out STD_LOGIC);
end ElapsedPercent;

architecture Behavioral of ElapsedPercent is
    signal i_TotalTime, i_CurrentTime: integer;
begin
    i_TotalTime <= to_integer(unsigned(TotalTime));
    i_CurrentTime <= to_integer(unsigned(CurrentTime));
    
    toLogic: process
    begin
        if (i_CurrentTime < (i_TotalTime * PercentToCheck) / 100) then
            BelowThreshold <= '1';
        else
            BelowThreshold <= '0';
        end if;
        wait for 1 ns;
    end process;
end Behavioral;
