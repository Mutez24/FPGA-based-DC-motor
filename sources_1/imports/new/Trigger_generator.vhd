----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2021 11:03:54 AM
-- Design Name: 
-- Module Name: Trigger_generator - Behavioral
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

entity Trigger_generator is
    Port ( clk : in STD_LOGIC;
           trigger : out STD_LOGIC);
end Trigger_generator;
architecture Behavioral of Trigger_generator is
begin
    trigger_process : process(clk)
    variable count_1: integer:= 0;
    variable count_0: integer:= 0;  
    begin 
        if(Clk'event and Clk='1') then    
            -- nous voulons espacer notre trigger de 70 ms (superieur au 60 ms recommande)
            if(count_0 <= 7000000) then
                count_1:=0;
                count_0:=count_0+1;
                trigger <= '0';  
            else
                count_1:=count_1+1;
                trigger <= '1';      
                -- nous voulons faire durer notre trigger 20 us (superieur au 10 us recommande)           
                if (count_1 > 2000) then
                    count_0:=0;
                end if;
            end if;                 
        end if;               
    end process;
end Behavioral;
