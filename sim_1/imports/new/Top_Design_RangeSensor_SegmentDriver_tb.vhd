-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Top_Design_RangeSensor_SegmentDriver_tb is
end;

architecture bench of Top_Design_RangeSensor_SegmentDriver_tb is

  component Top_Design_RangeSensor_SegmentDriver
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
             tapselDispD : out STD_LOGIC);
  end component;

  signal FPGA_Clock: STD_LOGIC;
  signal Pulse_from_sensor: STD_LOGIC;
  signal Trigger_to_sensor: STD_LOGIC;
  signal TopsegA: STD_LOGIC;
  signal TopsegB: STD_LOGIC;
  signal TopsegC: STD_LOGIC;
  signal TopsegD: STD_LOGIC;
  signal TopsegE: STD_LOGIC;
  signal TopsegF: STD_LOGIC;
  signal TopsegG: STD_LOGIC;
  signal tapselDispA: STD_LOGIC;
  signal tapselDispB: STD_LOGIC;
  signal tapselDispC: STD_LOGIC;
  signal tapselDispD: STD_LOGIC;
  
  constant clock_period: time := 10 ns;

begin

  uut: Top_Design_RangeSensor_SegmentDriver port map ( FPGA_Clock        => FPGA_Clock,
                                                       Pulse_from_sensor => Pulse_from_sensor,
                                                       Trigger_to_sensor => Trigger_to_sensor,
                                                       TopsegA           => TopsegA,
                                                       TopsegB           => TopsegB,
                                                       TopsegC           => TopsegC,
                                                       TopsegD           => TopsegD,
                                                       TopsegE           => TopsegE,
                                                       TopsegF           => TopsegF,
                                                       TopsegG           => TopsegG,
                                                       tapselDispA       => tapselDispA,
                                                       tapselDispB       => tapselDispB,
                                                       tapselDispC       => tapselDispC,
                                                       tapselDispD       => tapselDispD );

  stimulus: process
  begin
    
    Pulse_from_sensor <= '0';
        
    -- Simulate behaviour of HC-SR04 where echo signal last for 500us
    
    wait for 10ms;
    
    Pulse_from_sensor <= '1';
    wait for 500us;
    
    Pulse_from_sensor <= '0';
    wait for 60ms;
  
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 20ms
    
    wait for 10ms;
    
    Pulse_from_sensor <= '1';
    wait for 20ms;
    
    Pulse_from_sensor <= '0';
    wait for 40ms;
    
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 124us --> (out of range sensor)
    
    wait for 10ms;
    
    Pulse_from_sensor <= '1';
    wait for 124us;
    
    Pulse_from_sensor <= '0';
    wait for 60ms;
    
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 26ms --> DON'T WORK (out of range sensor)
    
    wait for 10ms;
    
    Pulse_from_sensor <= '1';
    wait for 26ms;
    
    Pulse_from_sensor <= '0';
    wait for 34ms;
    
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 30ms --> (out of range sensor + out of range distance vector)
     
    wait for 10ms;
    
    Pulse_from_sensor <= '1';
    wait for 30ms;
    
    Pulse_from_sensor <= '0';
    wait for 30ms;


    wait;
  end process;

  clocking: process
  begin
      FPGA_Clock <= '0';
      wait for clock_period / 2;
      FPGA_Clock <= '1';
      wait for clock_period / 2;
  end process;

end;