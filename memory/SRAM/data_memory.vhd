library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is generic(
        word: integer := 31
    );
    port(
        clk: in std_logic;
        we: in std_logic;
        address: in std_logic_vector (word downto 0);
        wd: in std_logic_vector (word downto 0);
        rd: out std_logic_vector (word downto 0)
    );
end data_memory;

architecture arch of data_memory is


begin

end architecture;