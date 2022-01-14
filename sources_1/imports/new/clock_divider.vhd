----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/01/2021 03:02:44 PM
-- Design Name: 
-- Module Name: clock_divider - Seven Segment Displayer
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_divider is
    Port ( Clk : in STD_LOGIC;
           slow_clock : out STD_LOGIC);
end clock_divider;

architecture Seven_Segment_Displayer of clock_divider is
-- Un signal est comme une variable global, il peut etre utilise dans plusieurs process
-- Pour assigner une valeur Ã  un signal on fait "<="
signal tmp : std_logic := '0';

begin
    process(Clk)
        -- Variable uniquement dans ce process
        -- Pour assigner une valeur a  une variable on fait ":="
        variable count: integer:= 0;
        begin
            -- Dans la premiere iteration, cela va initialiser la clock de sortie a  tmp
            -- Puis apres cela va juste assigner la valeur de tmp a  la clock de sortie
            slow_clock <= tmp;
      
            -- Si on a un evenement sur la clock interne (front montant ou front descendant) ET que c'est un front montant.
            -- En theorie on pourrait aussi le faire avec un front descendant mais il faut le mettre
            if(Clk'event and Clk='1') then
                count:=count+1;
                
                -- La clock interne est de 100MHz ce qui fait 1 nanoseconde or on veut 1 milliseconde car cela sera
                -- le taux de rafraichissement et 1 nanoseconde est trop court pour qu'on puisse voir un changement
                if(count=100000/2) then
                    -- Inversion du signal de sortie (on veut un 1 puis un 0 pour avoir le signal carre)
                    tmp <= not(tmp);
                    count:=1;  
                end if;                 
            end if;               
    end process;                
end Seven_Segment_Displayer;
