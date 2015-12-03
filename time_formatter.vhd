----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2015 02:21:18 PM
-- Design Name: 
-- Module Name: time_formatter - Behavioral
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


entity time_formatter is
    Port ( raw_seconds : in STD_LOGIC_VECTOR (11 downto 0);
           formatted_time : out STD_LOGIC_VECTOR (11 downto 0));
end time_formatter;

architecture Behavioral of time_formatter is

    signal raw_seconds_int : integer := 0;
    signal seconds_int : integer;
    signal minutes_int : integer;
    signal seconds_binary : std_logic_vector (5 downto 0);
    signal minutes_binary : std_logic_vector (5 downto 0);
    
begin

    convert_seconds: process(raw_seconds) begin 
        raw_seconds_int <= to_integer(unsigned(raw_seconds));
    end process convert_seconds;
    
    format_seconds: process(raw_seconds_int) begin
        seconds_int <= raw_seconds_int mod 60;
    end process format_seconds;
    
    format_minutes: process(seconds_int) begin
        minutes_int <= (raw_seconds_int - seconds_int) / 60;
    end process format_minutes;
        
    reconvert: process(minutes_int) begin
        seconds_binary <= std_logic_vector(to_unsigned(seconds_int, 6));
        minutes_binary <= std_logic_vector(to_unsigned(minutes_int, 6));
    end process reconvert;
    
    set_time: process(seconds_binary, minutes_binary) begin
        formatted_time(0) <= seconds_binary(0);
        formatted_time(1) <= seconds_binary(1);
        formatted_time(2) <= seconds_binary(2);
        formatted_time(3) <= seconds_binary(3);
        formatted_time(4) <= seconds_binary(4);
        formatted_time(5) <= seconds_binary(5);
        
        formatted_time(6) <= minutes_binary(0);
        formatted_time(7) <= minutes_binary(1);
        formatted_time(8) <= minutes_binary(2);
        formatted_time(9) <= minutes_binary(3);
        formatted_time(10) <= minutes_binary(4);
        formatted_time(11) <= minutes_binary(5);
    end process set_time;
        

end Behavioral;
