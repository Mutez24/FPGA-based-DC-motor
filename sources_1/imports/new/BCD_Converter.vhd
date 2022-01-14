----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/25/2021 12:31:52 PM
-- Design Name: 
-- Module Name: BCD_Converter - Behavioral
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

entity BCD_Converter is
    Port ( distance_in_binary : in STD_LOGIC_VECTOR (8 downto 0);
           hundreds_in_binary : out STD_LOGIC_VECTOR (3 downto 0);
           tens_in_binary : out STD_LOGIC_VECTOR (3 downto 0);
           units_in_binary : out STD_LOGIC_VECTOR (3 downto 0));
end BCD_Converter;

architecture Behavioral of BCD_Converter is
begin
-- process is sensitive to changes in distance_in_binary as it defines when the numbers displayed need to change
BCD_Converter : process (distance_in_binary)

-- temporary values of the different columns
variable temp_distance_in_binary : STD_LOGIC_VECTOR (8 downto 0) := (others=>'0'); 
variable temp_hundreds_in_binary : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0'); 
variable temp_tens_in_binary : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0'); 
variable temp_units_in_binary : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0'); 

-- temporary value of the whole line (as defined in the example of the course)
variable temp_all : STD_LOGIC_VECTOR (20 downto 0) := (others=>'0'); 
begin
-- create initial line
temp_all := "000000000000" & distance_in_binary ;
-- As defined in the algorithm, we need to do the shift-add 8 times and a final 9th time because we have 9 bit-vectors
for count in 0 to 7 loop
    -- Bit shift to the left
    temp_all := temp_all (19 downto 0) & '0';
    -- Extract columns values
    temp_hundreds_in_binary := temp_all(20 downto 17);
    temp_tens_in_binary := temp_all(16 downto 13);
    temp_units_in_binary := temp_all(12 downto 9);
    temp_distance_in_binary := temp_all(8 downto 0);
    -- Check if value greater than 4
    if temp_hundreds_in_binary > "0100"
    then
        temp_hundreds_in_binary := temp_hundreds_in_binary + 3;
    end if;
    if temp_tens_in_binary > "0100"
    then
        temp_tens_in_binary := temp_tens_in_binary + 3;
    end if;
    if temp_units_in_binary > "0100"
    then
        temp_units_in_binary := temp_units_in_binary + 3;
    end if;
    -- Concatenate the differents parts into the line again
    temp_all := temp_hundreds_in_binary & temp_tens_in_binary & temp_units_in_binary & temp_distance_in_binary;
end loop;
-- Final shift after which no add is necessary
temp_all := temp_all (19 downto 0) & '0';
-- Define final values
hundreds_in_binary <= temp_all(20 downto 17);
tens_in_binary <= temp_all(16 downto 13);
units_in_binary <= temp_all(12 downto 9);
end process;
end Behavioral;