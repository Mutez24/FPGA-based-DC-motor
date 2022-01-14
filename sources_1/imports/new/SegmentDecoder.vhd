----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2021 04:47:07 PM
-- Design Name: 
-- Module Name: SegmentDecoder - Behavioral
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

entity SegmentDecoder is
    Port ( Digit : in STD_LOGIC_VECTOR(3 downto 0); -- vecteur de 4 bits avec le bit 4 a gauche
           -- Segment = barre sur les digits. Pour en allumer un on le met a 0 et pour l'eteindre on le met a 1
           segment_A : out STD_LOGIC;
           segment_B : out STD_LOGIC;
           segment_C : out STD_LOGIC;
           segment_D : out STD_LOGIC;
           segment_E : out STD_LOGIC;
           segment_F : out STD_LOGIC;
           segment_G : out STD_LOGIC);
end SegmentDecoder;

architecture Behavioral of SegmentDecoder is

begin
process(Digit)
    variable Decode_Data: std_logic_vector(6 downto 0);
    begin
    case Digit is
    -- la on veut activer les segments pour pouvoir representer les chiffres en digit
        when "0000" => Decode_Data:="1111110";--0
        when "0001" => Decode_Data:="0110000";--1
        when "0010" => Decode_Data:="1101101";--2
        when "0011" => Decode_Data:="1111001";--3
        when "0100" => Decode_Data:="0110011";--4
        when "0101" => Decode_Data:="1011011";--5
        when "0110" => Decode_Data:="1011111";--6
        when "0111" => Decode_Data:="1110000";--7
        when "1000" => Decode_Data:="1111111";--8
        when "1001" => Decode_Data:="1111011";--9
        when "1010" => Decode_Data:="1110111";--A
        when "1011" => Decode_Data:="0011111";--B
        when "1100" => Decode_Data:="1001110";--C
        when "1101" => Decode_Data:="0111101";--D
        when "1110" => Decode_Data:="1001111";--E
        when "1111" => Decode_Data:="1000111";--F
        when others => Decode_Data:="0110111";--Error 'H'
    end case;
    -- Par contre en realite, la FPGA comprend l'inverse donc pour le cas de 0 par exemple,
    -- il faut lui donner "0000001" car comme dit precedemment, un segment est allume pour la valeur 0 et eteint pour la valeur 1
    -- d'ou le "not" ici
    segment_A<= not Decode_Data(6); 
    segment_B<= not Decode_Data(5);
    segment_C<= not Decode_Data(4);
    segment_D<= not Decode_Data(3);
    segment_E<= not Decode_Data(2);
    segment_F<= not Decode_Data(1);
    segment_G<= not Decode_Data(0);
    end process;
end Behavioral;