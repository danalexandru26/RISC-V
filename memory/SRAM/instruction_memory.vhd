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
    type matrix is array(2**xlen downto 0) of std_logic_vector(word downto 0);
    signal instruction: matrix := (
        0 => x"00000000",
        1 => x"00000004",
        2 => x"00000008",
        3 => x"00000003",        
        4 => x"00000007",    
        5 => x"00000005",
        6 => x"00000006",
        7 => x"00000007",                    
        others => x"0000000f");
        
        signal output: std_logic_vector(word downto 0);
begin

    process(clk) begin
     if rising_edge(clk) then
        rd<= instruction(to_integer(unsigned(address(xlen-1 downto 2))));
    end if;
    end process;
end architecture;