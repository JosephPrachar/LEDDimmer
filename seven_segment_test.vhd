----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2015 04:36:35 PM
-- Design Name: 
-- Module Name: seven_segment_test - Behavioral
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

entity seven_segment_test is
    Port ( clk : in STD_LOGIC;
           max_time : in STD_LOGIC_VECTOR (11 downto 0);
           segments : out STD_LOGIC_VECTOR (7 downto 0);
           anodes : out STD_LOGIC_VECTOR (3 downto 0));
end seven_segment_test;

architecture Behavioral of seven_segment_test is

    component second_clock_divider is Port(
        old_clock : in STD_LOGIC;
        new_clock : out STD_LOGIC);
    end component second_clock_divider;
    
    component timer is Port(
        divided_clk : in STD_LOGIC;
        max_time : in STD_LOGIC_VECTOR (11 downto 0);
        seconds : out STD_LOGIC_VECTOR (11 downto 0));
    end component timer;
    
    component sseg_dec is Port(
        ALU_VAL : in std_logic_vector(11 downto 0); 
        VALID : in std_logic;
        CLK : in std_logic;
        DISP_EN : out std_logic_vector(3 downto 0);
        SEGMENTS : out std_logic_vector(7 downto 0));
   end component sseg_dec;
   
   signal new_clock : std_logic;
   signal seconds : std_logic_vector (11 downto 0);
   
begin

    new_clocker: second_clock_divider Port Map(old_clock => clk, new_clock => new_clock);
    timer_mod: timer Port Map(divided_clk => new_clock, max_time => max_time, seconds => seconds);
    disp: sseg_dec Port Map(ALU_VAL => seconds, VALID => '1', CLK => clk, DISP_EN => anodes, SEGMENTS => segments); 

end Behavioral;
