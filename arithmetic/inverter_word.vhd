library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inverter_word is generic(
    word: integer := 31
    );
    port(
        a: in std_logic_vector (word downto 0);
        q: out std_logic_vector (word downto 0)
    );
end inverter_word;

architecture arch of inverter_word is

begin
    q <= not a;
end architecture;
