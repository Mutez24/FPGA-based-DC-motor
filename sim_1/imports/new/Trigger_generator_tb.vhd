-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Trigger_generator_tb is
end;

architecture bench of Trigger_generator_tb is

  component Trigger_generator
      Port ( clk : in STD_LOGIC;
             trigger : out STD_LOGIC);
  end component;

  signal clk: STD_LOGIC;
  signal trigger: STD_LOGIC;
  
  constant clock_period: time := 10 ns;

begin

  uut: Trigger_generator port map ( clk     => clk,
                                    trigger => trigger );

  clocking: process
  begin
      clk <= '0';
      wait for clock_period / 2;
      clk <= '1';
      wait for clock_period / 2;
  end process;
  
  stimulus: process
  begin

    wait;
  end process;


end;