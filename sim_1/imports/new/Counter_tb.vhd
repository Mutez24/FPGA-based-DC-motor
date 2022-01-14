----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2021 03:40:15 PM
-- Design Name: 
-- Module Name: Counter_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter_tb is
--  Port ( );
end Counter_tb;

architecture Behavioral of Counter_tb is

component Counter
Port (clk : in STD_LOGIC;
    enable : in STD_LOGIC;
    reset : in STD_LOGIC;
    counter_pulse_out : out std_logic_vector (21 downto 0));
end component;

signal clk :  STD_LOGIC;
signal enable : STD_LOGIC;
signal reset : STD_LOGIC;
signal counter_pulse_out : std_logic_vector (21 downto 0);

constant clock_period: time := 10 ns;

begin

uut : Counter port map(clk => clk, 
                       enable => enable, 
                       reset => reset, 
                       counter_pulse_out => counter_pulse_out);

clocking: process
  begin
      clk <= '0';
      wait for clock_period / 2;
      clk <= '1';
      wait for clock_period / 2;
  end process;
  
stimulus: process
  begin
    enable <= '0';
    reset <= '0';
    wait for 10ms;
        
        
    -- Simulate behaviour of HC-SR04 where echo signal last for 500us
    
    wait for 10ms;
    
    reset <= '1';
    wait for 20us;
    
    reset <= '0';
    wait for 20ms;
    
    enable <= '1';
    wait for 500us;
    
    enable <= '0';
    wait for 50ms;
  
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 20ms
    
    wait for 10ms;
    
    reset <= '1';
    wait for 20 us;
    
    reset <= '0';
    wait for 20ms;
    
    enable <= '1';
    wait for 20ms;
    
    enable <= '0';
    wait for 20ms;
    
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 124us --> (out of range sensor)
    
    wait for 10ms;
    
    reset <= '1';
    wait for 20 us;
    
    reset <= '0';
    wait for 20ms;
    
    enable <= '1';
    wait for 124us;
    
    enable <= '0';
    wait for 50ms;
    
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 26ms --> DON'T WORK (out of range sensor)
    
    wait for 10ms;
    
    reset <= '1';
    wait for 20 us;
    
    reset <= '0';
    wait for 20ms;
    
    enable <= '1';
    wait for 26ms;
    
    enable <= '0';
    wait for 24ms;
    
    
    -- Simulate behaviour of HC-SR04 where echo signal last for 30ms --> (out of range sensor + out of range distance vector)
     
    wait for 10ms;
    
    reset <= '1';
    wait for 20 us;
    
    reset <= '0';
    wait for 20ms;
    
    enable <= '1';
    wait for 30ms;
    
    enable <= '0';
    wait for 10ms;
    
        
    wait;
end process;


end Behavioral;
