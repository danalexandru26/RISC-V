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
        0 => x"0062E233",
        1 => x"00126233",
        2 => x"0062E233",
        3 => x"00116233",        
        4 => x"00000000",    
        5 => x"00000000",
        6 => x"00000000",
        7 => x"00000000",                    
        others => x"0000000f");
        
begin
    process(clk, address) begin
     if rising_edge(clk) then
        rd<= instruction(to_integer(unsigned(address(7 downto 2))));
    end if;
    end process;
end architecture;