----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2021 12:09:32 PM
-- Design Name: 
-- Module Name: Top_Design_RangeSensor_SegmentDriver - Behavioral
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

entity Top_Design_RangeSensor_SegmentDriver is
    Port ( FPGA_Clock : in STD_LOGIC;
           Pulse_from_sensor : in STD_LOGIC;
           Trigger_to_sensor : out STD_LOGIC;
           TopsegA : out STD_LOGIC;
           TopsegB : out STD_LOGIC;
           TopsegC : out STD_LOGIC;
           TopsegD : out STD_LOGIC;
           TopsegE : out STD_LOGIC;
           TopsegF : out STD_LOGIC;
           TopsegG : out STD_LOGIC;
           tapselDispA : out STD_LOGIC;
           tapselDispB : out STD_LOGIC;
           tapselDispC : out STD_LOGIC;
           tapselDispD : out STD_LOGIC;
           tapselDispE : out STD_LOGIC;
           tapselDispF : out STD_LOGIC;
           tapselDispG : out STD_LOGIC;
           tapselDispH : out STD_LOGIC;
           sw2_FPGA : in STD_LOGIC;
           IN1_to_HBridge : out STD_LOGIC;
           IN2_to_HBridge : out STD_LOGIC;
           ENA_to_HBridge : out STD_LOGIC);
end Top_Design_RangeSensor_SegmentDriver;

architecture Behavioral of Top_Design_RangeSensor_SegmentDriver is

component SegmentDriver is
    Port ( display_A : in STD_LOGIC_VECTOR (3 downto 0);
        display_B : in STD_LOGIC_VECTOR (3 downto 0);
        display_C : in STD_LOGIC_VECTOR (3 downto 0);
        display_D : in STD_LOGIC_VECTOR (3 downto 0); -- Will be assigned to the D, E, F, G, H digits
        segA : out STD_LOGIC;
        segB : out STD_LOGIC;
        segC : out STD_LOGIC;
        segD : out STD_LOGIC;
        segE : out STD_LOGIC;
        segF : out STD_LOGIC;
        segG : out STD_LOGIC;
        select_Display_A : out STD_LOGIC;
        select_Display_B : out STD_LOGIC;
        select_Display_C : out STD_LOGIC;
        select_Display_D : out STD_LOGIC;
        select_Display_E : out STD_LOGIC; 
        select_Display_F : out STD_LOGIC; 
        select_Display_G : out STD_LOGIC; 
        select_Display_H : out STD_LOGIC; 
        clk : in STD_LOGIC);
end component;
component Range_Sensor_Module is
    Port ( FPGA_Clock_range_sensor_module : in STD_LOGIC;
           Pulse_range_sensor_module : in STD_LOGIC;
           Trigger_range_sensor_module : out STD_LOGIC;
           hundreds_in_binary_range_sensor_module : out STD_LOGIC_VECTOR (3 downto 0);
           tens_in_binary_range_sensor_module : out STD_LOGIC_VECTOR (3 downto 0);
           units_in_binary_range_sensor_module : out STD_LOGIC_VECTOR (3 downto 0);
           distance_to_control_DC_Motor : out STD_LOGIC_VECTOR (8 downto 0));
end component;
component Control_DC_Motor is
    Port ( clk : in STD_LOGIC;
            sw2 : in STD_LOGIC;
            distance_to_control_DC_Motor : in STD_LOGIC_VECTOR (8 downto 0);
            IN1 : out STD_LOGIC;
            IN2 : out STD_LOGIC;
            --IN3 : out STD_LOGIC;
            --IN4 : out STD_LOGIC;
            ENA : out STD_LOGIC);
            --ENB : out STD_LOGIC);
end component;

-- les valeurs des unites, dizaines, centaines et la distance sont utilisees a plusieurs endroits d ou l utilisation de signaux internes
signal internal_hundreds_signal : STD_LOGIC_VECTOR (3 downto 0);
signal internal_tens_signal : STD_LOGIC_VECTOR (3 downto 0);
signal internal_units_signal : STD_LOGIC_VECTOR (3 downto 0);
signal internal_distance_to_control_DC_Motor_signal : STD_LOGIC_VECTOR (8 downto 0);

begin
    Range_Sensor_Module_Top_Design_RangeSensor_SegmentDriver : Range_Sensor_Module port map (FPGA_Clock_range_sensor_module => FPGA_Clock,
                                                                                             Pulse_range_sensor_module => Pulse_from_sensor,
                                                                                             Trigger_range_sensor_module => Trigger_to_sensor,
                                                                                             hundreds_in_binary_range_sensor_module => internal_hundreds_signal,
                                                                                             tens_in_binary_range_sensor_module => internal_tens_signal,
                                                                                             units_in_binary_range_sensor_module => internal_units_signal,
                                                                                             distance_to_control_DC_Motor => internal_distance_to_control_DC_Motor_signal);
    SegmentDriver_Top_Design_RangeSensor_SegmentDriver : SegmentDriver port map (display_A => internal_units_signal,
                                                                                 display_B => internal_tens_signal,
                                                                                 display_C => internal_hundreds_signal, -- the order on the FPGA board is DCBA (left to right)
                                                                                 display_D => "0000",
                                                                                 segA => TopsegA,
                                                                                 segB => TopsegB,
                                                                                 segC => TopsegC,
                                                                                 segD => TopsegD,
                                                                                 segE => TopsegE,
                                                                                 segF => TopsegF,
                                                                                 segG => TopsegG,
                                                                                 select_Display_A => tapselDispA,
                                                                                 select_Display_B => tapselDispB,
                                                                                 select_Display_C => tapselDispC,
                                                                                 select_Display_D => tapselDispD,
                                                                                 select_Display_E => tapselDispE,
                                                                                 select_Display_F => tapselDispF,
                                                                                 select_Display_G => tapselDispG,
                                                                                 select_Display_H => tapselDispH,
                                                                                 clk => FPGA_Clock);                                                                                   
    Control_DC_Motor_Top_Design_RangeSensor_SegmentDriver : Control_DC_Motor port map (clk => FPGA_Clock,
                                                                                        sw2 => sw2_FPGA,
                                                                                        distance_to_control_DC_Motor => internal_distance_to_control_DC_Motor_signal,
                                                                                        IN1 => IN1_to_HBridge,
                                                                                        IN2 => IN2_to_HBridge,
                                                                                        --IN3 : out STD_LOGIC;
                                                                                        --IN4 : out STD_LOGIC;
                                                                                        ENA => ENA_to_HBridge);
                                                                                        --ENB : out STD_LOGIC););                                                                         
end Behavioral;
