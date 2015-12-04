----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2015 05:02:02 PM
-- Design Name: 
-- Module Name: LEDDimmer - Behavioral
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

entity LEDDimmer is
    Port ( CLK : in STD_LOGIC;
           LightSwitch : in STD_LOGIC_VECTOR (2 downto 0);
           Refresh : in STD_LOGIC;
           Disp_En : out STD_LOGIC_VECTOR (3 downto 0);
           Disp_Segments : out STD_LOGIC_VECTOR (7 downto 0);
           LED : out STD_LOGIC_VECTOR (7 downto 0) := "00000000";
           Ref : out STD_LOGIC_VECTOR (7 downto 0) := "11111111");
end LEDDimmer;

architecture Behavioral of LEDDimmer is
    component DetectChange Port ( Clk : in STD_LOGIC;
               LightSwitch_in : in STD_LOGIC_VECTOR (2 downto 0);
               LightSwitch_out : out STD_LOGIC_VECTOR (2 downto 0);
               Change : out STD_LOGIC);
    end component;
        
    component ElapsedPercent Port ( TotalTime : in STD_LOGIC_VECTOR (11 downto 0);
               CurrentTime : in STD_LOGIC_VECTOR (11 downto 0);
               PercentToCheck : in integer;
               BelowThreshold : out STD_LOGIC);
    end component;
    
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
     end component;
     
     component LightSwitchDecoder Port ( LightSwitch : in STD_LOGIC_VECTOR (2 downto 0);
                TimeOut : out STD_LOGIC_VECTOR (11 downto 0);
                RateOfChange : out STD_LOGIC_VECTOR (5 downto 0);
                Off : out STD_LOGIC);
     end component;
     
     component sseg_dec Port ( ALU_VAL : in std_logic_vector(11 downto 0); 
                VALID : in std_logic;
                CLK : in std_logic;
                DISP_EN : out std_logic_vector(3 downto 0);
                SEGMENTS : out std_logic_vector(7 downto 0));
     end component;
     
     component intensity_clock_divider Port ( second_clock : in STD_LOGIC;
                rate_of_change : in STD_LOGIC_VECTOR (5 downto 0);
                intensity_clock : out STD_LOGIC);
     end component;
     
     component intensity_down_counter Port ( intensity_clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                set_to_half : in STD_LOGIC;
                set_to_zero : in STD_LOGIC;
                intensity : out STD_LOGIC_VECTOR (6 downto 0));
     end component;
     
     component second_clock_divider Port ( old_clock : in STD_LOGIC;
                new_clock : out STD_LOGIC);
     end component;
     
     component timer Port ( divided_clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                max_time : in STD_LOGIC_VECTOR (11 downto 0);
                seconds : out STD_LOGIC_VECTOR (11 downto 0));
     end component;
     
     component pwm Port (clk : in STD_LOGIC;
                intensity : in STD_LOGIC_VECTOR (6 downto 0);
                led_clk : out STD_LOGIC);
     end component;
     
     component resetMod Port ( clk : in STD_LOGIC;
               reset_in : in STD_LOGIC;
               reset_out : out STD_LOGIC);
     end component;
     
     signal Change, TotalRefresh, Off, At20, 
            At50, Clk_Intensity, Clk_Second, 
            Countdown, SetTo100, reset_mod, SetTo50, SetTo0, LED_s : STD_LOGIC;
     signal s_LightSwitch: STD_LOGIC_VECTOR (2 downto 0);
     signal RateOfChange: STD_LOGIC_VECTOR (5 downto 0);
     signal Intensity: STD_LOGIC_VECTOR (6 downto 0);
     signal TotalTime, CurrentTime : STD_LOGIC_VECTOR (11 downto 0);
begin
    detectChange_m: DetectChange PORT MAP (CLK, LightSwitch, s_LightSwitch, Change);
    TotalRefresh <= Change or Refresh;
    
    decoder: LightSwitchDecoder PORT MAP (s_LightSwitch, TotalTime, RateOfChange, Off);
    
    past50: ElapsedPercent PORT MAP (TotalTime, CurrentTime, 50, At50);
    past20: ElapsedPercent PORT MAP (TotalTime, CurrentTime, 20, At20);
    
    fsm: MainFSM PORT MAP (Off, Clk_Second, At20, At50, Clk_Intensity, TotalRefresh, 
                            Countdown, SetTo100, SetTo50, SetTo0);
    
    secondClock: second_clock_divider PORT MAP (CLK, Clk_Second);
    intensityClock: intensity_clock_divider PORT MAP (Clk_Second, RateOfChange, Clk_Intensity);
    modify_reset: resetMod PORT MAP (CLK, SetTo100, reset_mod);
    toSecondsClkDiv: Timer PORT MAP (Clk_Second, reset_mod, TotalTime, CurrentTime);
    
    display: sseg_dec PORT MAP(CurrentTime, '1', CLK, Disp_En, Disp_Segments);
    
    IntensityDownCounter: intensity_down_counter PORT MAP (Clk_Intensity, SetTo100, SetTo50, SetTo0, Intensity);
    
    dimmer_pwm : pwm PORT MAP(CLK, Intensity, LED_s);
    
    LED(0) <= LED_s;
   -- LED(1) <= LED_s;
   -- LED(2) <= LED_s;
   -- LED(3) <= LED_s;
   -- LED(4) <= LED_s;
   -- LED(5) <= LED_s;
   -- LED(6) <= LED_s;
   -- LED(7) <= LED_s;
    
    
    
end Behavioral;
