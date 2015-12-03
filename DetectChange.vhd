----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2015 11:21:10 AM
-- Design Name: 
-- Module Name: DetectChange - Behavioral
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
