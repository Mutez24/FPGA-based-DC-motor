----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2021 03:52:34 PM
-- Design Name: 
-- Module Name: Distance_calculations - Behavioral
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

entity Distance_calculations is
    Port ( clk : in STD_LOGIC;
           pulse : in STD_LOGIC;
           trigger : in STD_LOGIC;
           counter_pulse_out : in STD_LOGIC_VECTOR (21 downto 0);
           distance : out STD_LOGIC_VECTOR (8 downto 0));
end Distance_calculations;
architecture Behavioral of Distance_calculations is
signal divisor : STD_LOGIC_VECTOR (21 downto 0) := conv_std_logic_vector(5800,22);
begin
    distance_calculation_process: process(clk)
    begin 
        if clk'event and clk = '1'
        then
            -- Ici nous prenons en compte la range max et min du capteur de distance
            -- ainsi, si celui ci nous donne une valeur absurde nous pourrons le constater en affichant 511 sur les displays
            -- car distance est un vecteur de 9 bits et dans ce cas la, tous ses bits seront a 1 (ce qui donne 511 en decimal)
            if counter_pulse_out > 2500000 or counter_pulse_out < 12500
            then
                distance <= (others=>'1');
            -- ici on calcule la distance reelle avec la formule distance = Temps_Echo / 58
            else
                distance <= conv_std_logic_vector(conv_integer(counter_pulse_out)/conv_integer(divisor),9);
            end if;
        end if;
    end process;
end Behavioral;
