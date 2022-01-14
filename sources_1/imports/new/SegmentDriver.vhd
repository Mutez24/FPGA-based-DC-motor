----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2021 04:48:50 PM
-- Design Name: 
-- Module Name: SegmentDriver - Behavioral
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

entity SegmentDriver is
    Port (
        -- Le Display D est le quatrième en partant de l'extrémité droite, il sera donc toujours égal à 0 puisque 
        -- nous n'aurons que 3 chiffres pour la distance.  
        -- De plus, le display D sera utilise pour les 4 displays autres display (ceux de gauche) car comme le display D, 
        -- ils seront toujours egaux a 0
        display_A : in STD_LOGIC_VECTOR (3 downto 0);
        display_B : in STD_LOGIC_VECTOR (3 downto 0);
        display_C : in STD_LOGIC_VECTOR (3 downto 0); 
        display_D : in STD_LOGIC_VECTOR (3 downto 0); 
        segA : out STD_LOGIC;
        segB : out STD_LOGIC;
        segC : out STD_LOGIC;
        segD : out STD_LOGIC;
        segE : out STD_LOGIC;
        segF : out STD_LOGIC;
        segG : out STD_LOGIC;
        select_Display_A : out STD_LOGIC;
        select_Display_B : out STD_LOGIC; 
        select_Display_C : out STD_LOGIC; 
        select_Display_D : out STD_LOGIC; 
        select_Display_E : out STD_LOGIC; 
        select_Display_F : out STD_LOGIC; 
        select_Display_G : out STD_LOGIC; 
        select_Display_H : out STD_LOGIC; 
        clk : in STD_LOGIC);
end SegmentDriver;

architecture Behavioral of SegmentDriver is
    component SegmentDecoder is 
        Port ( Digit : in STD_LOGIC_VECTOR (3 downto 0);
            segment_A : out STD_LOGIC;
            segment_B : out STD_LOGIC;
            segment_C : out STD_LOGIC;
            segment_D : out STD_LOGIC;
            segment_E : out STD_LOGIC;
            segment_F : out STD_LOGIC;
            segment_G : out STD_LOGIC);
    end component;
    
    component clock_divider is
        Port ( clk : in STD_LOGIC;
            slow_clock : out STD_LOGIC);
    end component;
    
    signal temporary_data : STD_LOGIC_VECTOR(3 downto 0);
    signal slow_clock: STD_LOGIC;

    begin
        -- Ici on declare les components avec les variables utilises par l'entity
        uut: SegmentDecoder port map (temporary_data, segA,segB,segC,segD,segE,segF,segG);
        uut1: clock_divider port map (clk,slow_clock);
        
        process(slow_clock)
            variable display_selection: std_logic_vector(1 downto 0) := "00";
            begin
            if slow_clock'event and slow_clock = '1' then
            case display_selection is
            -- le but ici c'est d'afficher chaque chiffre les uns apres les autres (on les affiche un par un en fonction de la clock, 
            -- autrement dit a chaque front montant de la clock, on veut changer quel afficheur est actif)
            -- On peut voir que l'on selectionne un display a chaque fois (celui qui est a '0' car 0 est la valeur pour afficher)
                when "00" => temporary_data <= display_A;
                    select_Display_A <= '0';
                    select_Display_B <= '1';
                    select_Display_C <= '1';
                    select_Display_D <= '1';
                    select_Display_E <= '1';
                    select_Display_F <= '1';
                    select_Display_G <= '1';
                    select_Display_H <= '1';
                    display_selection:= "01";
                when "01" => temporary_data <= display_B;
                    select_Display_A <= '1';
                    select_Display_B <= '0';
                    select_Display_C <= '1';
                    select_Display_D <= '1';
                    select_Display_E <= '1';
                    select_Display_F <= '1';
                    select_Display_G <= '1';
                    select_Display_H <= '1';
                    display_selection:= "10";
                when "10" => temporary_data <= display_C;
                    select_Display_A <= '1';
                    select_Display_B <= '1';
                    select_Display_C <= '0';
                    select_Display_D <= '1';
                    select_Display_E <= '1';
                    select_Display_F <= '1';
                    select_Display_G <= '1';
                    select_Display_H <= '1';
                    display_selection:= "11";
                when "11" => temporary_data <= display_D;
                    select_Display_A <= '1';
                    select_Display_B <= '1';
                    select_Display_C <= '1';
                    select_Display_D <= '0';
                    select_Display_E <= '0';
                    select_Display_F <= '0';
                    select_Display_G <= '0';
                    select_Display_H <= '0';
                    display_selection:= "00";
                when others => temporary_data <= display_D;
                    select_Display_A <= '1';
                    select_Display_B <= '1';
                    select_Display_C <= '1';
                    select_Display_D <= '1';
                    select_Display_E <= '1';
                    select_Display_F <= '1';
                    select_Display_G <= '1';
                    select_Display_H <= '1';
                    display_selection:= "00";
                end case;
            end if;
          end process;
end Behavioral;
