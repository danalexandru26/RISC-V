library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity xor_word is generic(
        word: integer := 31
    );

    port(
        x: in std_logic_vector (word downto 0);
        y: in std_logic_vector (word downto 0);
        q: out std_logic_vector (word downto 0)
    );
end xor_word;

architecture arch of xor_word is

begin
    q <= x xor y;
end architecture;