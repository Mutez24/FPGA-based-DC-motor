-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity clock_divider_tb is
end;

architecture bench of clock_divider_tb is

  component clock_divider
      Port ( Clk : in STD_LOGIC;
             Data_Clk : out STD_LOGIC);
  end component;

  signal Clk: STD_LOGIC;
  signal Data_Clk: STD_LOGIC;

  constant clock_period: time := 10 ns;
  --signal stop_the_clock: boolean;

begin

  uut: clock_divider port map ( Clk      => Clk,
                                Data_Clk => Data_Clk );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    --stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    
      Clk <= '0';
      wait for clock_period / 2;
      Clk <= '1';
      wait for clock_period / 2;
  end process;

end;