library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_memory is generic(
        word: integer := 31;
        xlen: integer := 8
    );
    port(
        clk: in std_logic;
        address: in std_logic_vector (word downto 0);
        rd: out std_logic_vector (word downto 0)
    );
end instruction_memory;

architecture arch of instruction_memory is
    type matrix is array(2**xlen - 1 downto 0) of std_logic_vector(word downto 0);
    signal instruction: matrix := (
        0 => x"0262A0A3",
        1=> x"0014A303",
        others => x"00000000");
        
begin
    process(clk, address) begin
     if rising_edge(clk) then
         if address /= x"UUUUUUUU" and address /= x"XXXXXXXX" then
            rd<= instruction(to_integer(unsigned(address(7 downto 2))));
        end if;
    end if;
    end process;
end architecture;
