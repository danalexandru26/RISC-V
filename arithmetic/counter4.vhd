library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC4 is generic(
        word: integer := 31
    );
    port(
        a: in std_logic_vector(word downto 0);
        q: out std_logic_vector(word downto 0)
    );
end PC4;

architecture arch of PC4 is

begin
    q <= std_logic_vector(unsigned(a) + 4); 
end architecture;