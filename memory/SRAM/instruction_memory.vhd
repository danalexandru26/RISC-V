library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_memory is generic(
        word: integer := 31;
        xlen: integer := 15
    );
    port(
        address: in std_logic_vector (xlen downto 0);
        rd: out std_logic_vector (word downto 0)
    );
end instruction_memory;

architecture arch of instruction_memory is


begin

end architecture;