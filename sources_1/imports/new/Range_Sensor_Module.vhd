----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2021 11:08:00 AM
-- Design Name: 
-- Module Name: Range_Sensor_Module - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Range_Sensor_Module is
    Port ( FPGA_Clock_range_sensor_module : in STD_LOGIC;
           Pulse_range_sensor_module : in STD_LOGIC;
           Trigger_range_sensor_module : out STD_LOGIC;
           hundreds_in_binary_range_sensor_module : out STD_LOGIC_VECTOR (3 downto 0);
           tens_in_binary_range_sensor_module : out STD_LOGIC_VECTOR (3 downto 0);
           units_in_binary_range_sensor_module : out STD_LOGIC_VECTOR (3 downto 0);
           distance_to_control_DC_Motor : out STD_LOGIC_VECTOR (8 downto 0));
end Range_Sensor_Module;

architecture Behavioral of Range_Sensor_Module is
    component Trigger_generator is
        Port ( clk : in STD_LOGIC;
               trigger : out STD_LOGIC);
    end component;
    component Counter is
        Port (  clk : in STD_LOGIC;
                enable : in STD_LOGIC;
                reset : in STD_LOGIC;
                counter_pulse_out : out std_logic_vector (21 downto 0));
    end component;
    component Distance_calculations is
        Port ( clk : in STD_LOGIC;
               pulse : in STD_LOGIC;
               trigger : in STD_LOGIC;
               counter_pulse_out : in STD_LOGIC_VECTOR (21 downto 0);
               distance : out STD_LOGIC_VECTOR (8 downto 0));
    end component;
    component BCD_Converter is
        Port ( distance_in_binary : in STD_LOGIC_VECTOR (8 downto 0);
               hundreds_in_binary : out STD_LOGIC_VECTOR (3 downto 0);
               tens_in_binary : out STD_LOGIC_VECTOR (3 downto 0);
               units_in_binary : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

-- le trigger, l'echo et la distance etant utilise a plusieurs endroits, nous devons utiliser des signaux internes
signal internal_trigger_signal : STD_LOGIC;
signal internal_counter_pulse_out_signal : STD_LOGIC_VECTOR (21 downto 0);
signal internal_distance_signal : STD_LOGIC_VECTOR (8 downto 0);
begin
    Trigger_generator_range_sensor_module: Trigger_generator port map (clk => FPGA_Clock_range_sensor_module,
                                                                       trigger => internal_trigger_signal);                                     
    Counter_range_sensor_module: Counter port map (clk => FPGA_Clock_range_sensor_module,
                                                   enable => Pulse_range_sensor_module,
                                                   reset => internal_trigger_signal,
                                                   counter_pulse_out => internal_counter_pulse_out_signal);   
    Distance_calculations_range_sensor_module: Distance_calculations port map (clk => FPGA_Clock_range_sensor_module,
                                                                               pulse => Pulse_range_sensor_module,
                                                                               trigger => internal_trigger_signal,
                                                                               counter_pulse_out => internal_counter_pulse_out_signal,
                                                                               distance => internal_distance_signal);
    BCD_Converter_range_sensor_module: BCD_Converter port map (distance_in_binary => internal_distance_signal,
                                                               hundreds_in_binary => hundreds_in_binary_range_sensor_module,
                                                               tens_in_binary => tens_in_binary_range_sensor_module,
                                                               units_in_binary => units_in_binary_range_sensor_module);
    Trigger_range_sensor_module <= internal_trigger_signal;          
    distance_to_control_DC_Motor <= internal_distance_signal;     
end Behavioral;