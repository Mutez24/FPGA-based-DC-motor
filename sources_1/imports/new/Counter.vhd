----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2021 03:36:36 PM
-- Design Name: 
-- Module Name: Counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Counter is
    Port ( 
    clk : in STD_LOGIC;
    enable : in STD_LOGIC;
    reset : in STD_LOGIC;
    counter_pulse_out : out std_logic_vector (21 downto 0)
    );
end Counter;

architecture Behavioral of Counter is
-- Definition of internal signal
signal temp_counter_pulse_out :  std_logic_vector (21 downto 0) := (others=>'0');
begin
-- process of time measuring begins
counting : process (clk)
    -- allow us to avoid sending data just after the trigger
    variable send_data : std_logic := '0';
    begin
    if clk'event and clk = '1'
        -- lorsque l on envoie un nouveau signal trigger, on reinitialise le compteur servant a compter la duree d un echo
        then if reset = '1'
                then 
                temp_counter_pulse_out <= (others=>'0');
                send_data := '0';
             -- on compter le temps de l echo
             elsif enable = '1'
                then 
                temp_counter_pulse_out <= temp_counter_pulse_out +1;
                send_data := '1';
             -- une fois que l echo est termine (low), on l envoie
             elsif enable = '0' and send_data = '1'
                then counter_pulse_out <= temp_counter_pulse_out;
             end if;
    end if;
end process;
end Behavioral;