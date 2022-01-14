----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2021 11:33:46
-- Design Name: 
-- Module Name: Control_DC_Motor - Behavioral
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

entity Control_DC_Motor is
    Port ( clk : in STD_LOGIC;
            distance_to_control_DC_Motor : in STD_LOGIC_VECTOR (8 downto 0);
            sw2 : in STD_LOGIC;
            IN1 : out STD_LOGIC;
            IN2 : out STD_LOGIC;
            -- si on veut rajouter un deuxieme moteur
            --IN3 : out STD_LOGIC;
            --IN4 : out STD_LOGIC;
            ENA : out STD_LOGIC);
            -- si on veut rajouter un deuxieme moteur
            --ENB : out STD_LOGIC);
end Control_DC_Motor;

architecture Behavioral of Control_DC_Motor is
begin
process (clk)
    variable count_stop : integer:= 0;
    variable count_stop_2 : integer:= 0;
    variable count_turn : integer:= 0;
    variable Do_I_Stop : boolean := False;
    variable Do_I_Turn : boolean := False;
    variable speed: integer:= 0;
    variable count_speed: integer:= 0;
    
    begin
    -- pour gerer la vitesse on cree une variable qui permet d activer le moteur seulement 1/3 du temps
    -- si la distance est inferieur a 25 cm et superieur a 15 cm (car en dessous de 15 on est s arrete) on ralentit
    if ((distance_to_control_DC_Motor < conv_std_logic_vector(25,9)) and (distance_to_control_DC_Motor >= conv_std_logic_vector(15,9))) then
        speed:=30000;
    -- sinon on avance avec la vitesse maximum
    else
        speed:=100000;
    end if;
    
    if rising_edge (clk) then
        -- permet de gerer la vitesse
        count_speed := count_speed+1;
        if count_speed=99999 then
            count_speed := 0;
        end if;
        -- le switch 2 permet de gerer l alimentation du moteur
        -- si le sw2 est active, on allume le moteur
        if (sw2='1') then
            ENA <= '1';
            -- Si on vient de reculer, on doit s'arreter avant de repartir afin de ne pas brusquer le moteur
            -- Do_I_Stop est true quand on vient de reculer
            if (Do_I_Stop) then
                count_stop_2 := count_stop_2+1;
                IN1 <= '0';
                IN2 <= '0';
                if (count_stop_2 >= 200000000) then
                    Do_I_Stop := False;
                    count_stop_2 := 0;
                end if;
            -- si la distance est inferieur a 15 cm et ((on a pas tourne) ou (on a finis de tourner et y a encore un mur)), on s arrete
            elsif ((distance_to_control_DC_Motor < conv_std_logic_vector(15,9)) and (not Do_I_Turn)) then
                count_stop := count_stop+1;
                IN1 <= '0';
                IN2 <= '0';
                if (count_stop >= 200000000) then
                    Do_I_Turn := True;
                    count_stop := 0;
                end if;
            -- Si on s est arrete 1 seconde, on dois reculer 
            -- dans le but de tourner a 90 degres
            elsif (Do_I_Turn) then
                count_turn := count_turn+1;
                -- si on veut reculer
                IN1 <= '1';
                IN2 <= '0';
                -- on a finis de tourner, on remet les compteurs a zero et on s arrete
                if (count_turn  >= 200000000) then
                    Do_I_Turn := False;
                    count_turn := 0;
                    Do_I_Stop := True;
                end if;
            -- si on veut avancer
            else
                count_stop := 0;
                count_turn := 0;
                Do_I_Stop := False;
                Do_I_Turn := False;
                -- permet de gerer la vitesse
                if (count_speed < speed) then
                    IN1 <= '0';
                    IN2 <= '1';
                else
                    IN1 <= '0';
                    IN2 <= '0';
                end if ;
            end if ;
        -- si on eteint le moteur
        else
            ENA <= '0';
            IN1 <= '0';
            IN2 <= '0';
        end if ;
    end if;
end process ;

end Behavioral;

