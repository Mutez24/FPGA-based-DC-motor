-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Range_Sensor_Module_tb is
end;

architecture bench of Range_Sensor_Module_tb is

  component Range_Sensor_Module
      Port ( FPGA_Clock_range_sensor_module : in STD_LOGIC;
             Pulse_range_sensor_module : in STD_LOGIC;
             Trigger_range_sensor_module : out STD_LOGIC;
             hundreds_in_binary_range_sensor_module : out STD_LOGIC_VECTOR (3 downto 0);
             tens_in_binary_range_sensor_module : out STD_LOGIC_VECTOR (3 downto 0);
             units_in_binary_range_sensor_module : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  signal FPGA_Clock_range_sensor_module: STD_LOGIC;
  signal Pulse_range_sensor_module: STD_LOGIC;
  signal Trigger_range_sensor_module: STD_LOGIC;
  signal hundreds_in_binary_range_sensor_module: STD_LOGIC_VECTOR (3 downto 0);
  signal tens_in_binary_range_sensor_module: STD_LOGIC_VECTOR (3 downto 0);
  signal units_in_binary_range_sensor_module: STD_LOGIC_VECTOR (3 downto 0);
  
  constant clock_period: time := 10 ns;

begin

  uut: Range_Sensor_Module port map ( FPGA_Clock_range_sensor_module         => FPGA_Clock_range_sensor_module,
                                      Pulse_range_sensor_module              => Pulse_range_sensor_module,
                                      Trigger_range_sensor_module            => Trigger_range_sensor_module,
                                      hundreds_in_binary_range_sensor_module => hundreds_in_binary_range_sensor_module,
                                      tens_in_binary_range_sensor_module     => tens_in_binary_range_sensor_module,
                                      units_in_binary_range_sensor_module    => units_in_binary_range_sensor_module );

  stimulus: process
  begin
  
    Pulse_range_sensor_module <= '0';
        
    -- Simulate behaviour of HC-SR04 where echo signal last for 500us
    
    wait for 10ms;
    
    Pulse_range_sensor_module <= '1';
    wait for 500us;
    
    Pulse_range_sensor_module <= '0';
    wait for 60ms;
  
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 20ms
    
    wait for 10ms;
    
    Pulse_range_sensor_module <= '1';
    wait for 20ms;
    
    Pulse_range_sensor_module <= '0';
    wait for 40ms;
    
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 124us --> (out of range sensor)
    
    wait for 10ms;
    
    Pulse_range_sensor_module <= '1';
    wait for 124us;
    
    Pulse_range_sensor_module <= '0';
    wait for 60ms;
    
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 26ms --> DON'T WORK (out of range sensor)
    
    wait for 10ms;
    
    Pulse_range_sensor_module <= '1';
    wait for 26ms;
    
    Pulse_range_sensor_module <= '0';
    wait for 34ms;
    
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 30ms --> (out of range sensor + out of range distance vector)
     
    wait for 10ms;
    
    Pulse_range_sensor_module <= '1';
    wait for 30ms;
    
    Pulse_range_sensor_module <= '0';
    wait for 30ms;
    

    wait;
  end process;
  
  clocking: process
  begin
      FPGA_Clock_range_sensor_module <= '0';
      wait for clock_period / 2;
      FPGA_Clock_range_sensor_module <= '1';
      wait for clock_period / 2;
  end process;


end;