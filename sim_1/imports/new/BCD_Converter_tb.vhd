-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity BCD_Converter_tb is
end;

architecture bench of BCD_Converter_tb is

  component BCD_Converter
      Port ( distance_in_binary : in STD_LOGIC_VECTOR (8 downto 0);
             hundreds_in_binary : out STD_LOGIC_VECTOR (3 downto 0);
             tens_in_binary : out STD_LOGIC_VECTOR (3 downto 0);
             units_in_binary : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  signal distance_in_binary: STD_LOGIC_VECTOR (8 downto 0);
  signal hundreds_in_binary: STD_LOGIC_VECTOR (3 downto 0);
  signal tens_in_binary: STD_LOGIC_VECTOR (3 downto 0);
  signal units_in_binary: STD_LOGIC_VECTOR (3 downto 0);

begin

  uut: BCD_Converter port map ( distance_in_binary => distance_in_binary,
                                hundreds_in_binary => hundreds_in_binary,
                                tens_in_binary     => tens_in_binary,
                                units_in_binary    => units_in_binary );

  stimulus: process
  begin
  
    Distance_in_binary <= "000001000";
    wait for 25ms;
    
    Distance_in_binary <= "101011000";
    wait for 25ms;
    
    Distance_in_binary <= "111111111";
    wait for 25ms;

    wait;
  end process;


end;