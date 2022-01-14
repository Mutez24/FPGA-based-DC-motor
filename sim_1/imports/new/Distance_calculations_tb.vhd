----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2021 04:20:03 PM
-- Design Name: 
-- Module Name: Distance_calculations_tb - Behavioral
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


-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Distance_calculations_tb is
end;

architecture bench of Distance_calculations_tb is

component Distance_calculations
  Port ( clk : in STD_LOGIC;
         pulse : in STD_LOGIC;
         trigger : in STD_LOGIC;
         counter_pulse_out : in STD_LOGIC_VECTOR (21 downto 0);
         distance : out STD_LOGIC_VECTOR (8 downto 0));
end component;

signal clk: STD_LOGIC;
signal pulse: STD_LOGIC;
signal trigger: STD_LOGIC;
signal counter_pulse_out: STD_LOGIC_VECTOR (21 downto 0);
signal distance: STD_LOGIC_VECTOR (8 downto 0);

constant clock_period: time := 10 ns;

begin

uut: Distance_calculations port map ( clk               => clk,
                                      pulse             => pulse,
                                      trigger           => trigger,
                                      counter_pulse_out => counter_pulse_out,
                                      distance          => distance );

clocking: process
  begin
      clk <= '0';
      wait for clock_period / 2;
      clk <= '1';
      wait for clock_period / 2;
  end process;
  
  stimulus: process
  begin
    pulse <= '0';
    trigger <= '0';
    counter_pulse_out <= (others => '0');
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 500us --> WORKS
    
    wait for 10ms;
    
    trigger <= '1';
    wait for 20us;
    
    trigger <= '0';
    wait for 20ms;
    
    pulse <= '1';
    wait for 500us;
    
    pulse <= '0';
    counter_pulse_out <= conv_std_logic_vector(50000,22);
    wait for 50ms;
  
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 20ms --> WORKS
    
    wait for 10ms;
    
    trigger <= '1';
    wait for 20 us;
    
    trigger <= '0';
    wait for 20ms;
    
    pulse <= '1';
    wait for 20ms;
    
    pulse <= '0';
    counter_pulse_out <= conv_std_logic_vector(2000000,22);
    wait for 20ms;
    
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 124us --> DON'T WORK (out of range sensor)
    
    wait for 10ms;
    
    trigger <= '1';
    wait for 20 us;
    
    trigger <= '0';
    wait for 20ms;
    
    pulse <= '1';
    wait for 124us;
    
    pulse <= '0';
    counter_pulse_out <= conv_std_logic_vector(12400,22);
    wait for 50ms;
    
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 26ms --> DON'T WORK (out of range sensor)
    
    wait for 10ms;
    
    trigger <= '1';
    wait for 20 us;
    
    trigger <= '0';
    wait for 20ms;
    
    pulse <= '1';
    wait for 26ms;
    
    pulse <= '0';
    counter_pulse_out <= conv_std_logic_vector(2600000,22);
    wait for 24ms;
    
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 30ms --> DOES NOT WORK (out of range sensor + out of range distance vector)
    
    -- As a matter of fact, we have 30ms = 30000000ns so in the formula of the distance :
    -- 3000000/5800 (it's 3000000 and not 30000000 because the internal clock is 10ns).
    -- This calculation gives us 517,24 and the maximum value for the "distance" vector 
    -- is "111111111" in binary which is 511 in decimal. Therefore, when we have an echo
    -- of 30ms, we will go over the maximum value of the "distance" vector which leads to
    -- going back to the beginning of it and in this case we obtain a distance of 5cm.
    -- 517,24-511=6,24 but as we have to go over the value 0, we obtain 5cm. 
     
    wait for 10ms;
    
    trigger <= '1';
    wait for 20 us;
    
    trigger <= '0';
    wait for 20ms;
    
    pulse <= '1';
    wait for 30ms;
    
    pulse <= '0';
    counter_pulse_out <= conv_std_logic_vector(3000000,22);
    wait for 10ms;
        
    wait;
  end process;


end;