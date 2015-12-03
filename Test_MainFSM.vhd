----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2015 05:32:09 PM
-- Design Name: 
-- Module Name: Test_MainFSM - Behavioral
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

entity Test_MainFSM is
--  Port ( );
end Test_MainFSM;

architecture Behavioral of Test_MainFSM is
    component MainFSM Port ( Off : in STD_LOGIC;
       Clk : in STD_LOGIC;
       TimeAt20 : in STD_LOGIC;
       TimeAt50 : in STD_LOGIC;
       Clk_Intensity : in STD_LOGIC;
       Refresh : in STD_LOGIC;
       IntensityDown : out STD_LOGIC;
       ResetTime : out STD_LOGIC;
       Set50 : out STD_LOGIC;
       Set0 : out STD_LOGIC);
    end component MainFSM;
    
    signal s_off, s_Clk, s_TimeAt20, s_TimeAt50, s_Clk_Intensity, s_Refresh : STD_LOGIC;
    signal s_IntensityDown, s_ResetTime, s_Set50, s_Set0 : STD_LOGIC;
begin
    main_fsm: MainFSM PORT MAP 
        (s_Clk, s_TimeAt20, s_TimeAt50, s_Clk_Intensity, s_Refresh,
         s_IntensityDown, s_ResetTime, s_Set50, s_Set0);
         
    runClock: process
    begin
        s_Clk <= '0';
        wait for 1 ns;
        s_Clk <= '1';
        wait for 1 ns;
    end process;
    
    runIntensityClk: process
    begin
        s_Clk_Intensity <= '0';
        wait for 10 ns;
        s_Clk_intensity <= '1';
        wait for 10 ns;
    end process;
    
    testProcess: process
    begin
        -- start full run through test
        
        -- zero everything force to off state
        s_Off <= '1';
        wait for 5 ns;
        s_Off <= '0';
        s_TimeAt20 <= '0';
        s_TimeAt50 <= '0';
        s_Refresh <= '0';        
        wait for 10ns;
        
        -- simulate button press
        s_TimeAt20 <= '0';
        s_TimeAt50 <= '0';
        s_Refresh <= '1';
        wait for 5 ns;
        s_Refresh <= '0';
        wait for 50ns;
        
        s_TimeAt20 <= '0';
        s_TimeAt50 <= '1';
        s_Refresh <= '0';
        wait for 50ns;
        
        s_TimeAt20 <= '1';
        s_TimeAt50 <= '1';
        s_Refresh <= '0';
        wait for 50 ns;
        
        -- end full run through
        
        -- start check refresh state change
        
        -- zero everything force to off state
        s_Off <= '1';
        wait for 5 ns;
        s_Off <= '0';
        s_TimeAt20 <= '0';
        s_TimeAt50 <= '0';
        s_Refresh <= '0';        
        wait for 10ns;
        
        
    end process;

end Behavioral;
