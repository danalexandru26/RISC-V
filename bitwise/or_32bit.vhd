library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity or_32bit is port(
    x: in std_logic_vector (31 downto 0);
    y: in std_logic_vector (31 downto 0);
    q: out std_logic_vector (31 downto 0)
);
end or_32bit;

architecture arch of or_32bit is

begin
    q <= x or y;
end architecture;