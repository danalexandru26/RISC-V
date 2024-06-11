library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is generic(
        word: integer := 31;
        memory_size: integer := 8
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
    type matrix is array(2**memory_size downto 0) of std_logic_vector(word downto 0);

    signal data: matrix := (
        1 => x"00000001",
        2 => x"00000002",
        others => x"00000000");
    signal output: integer := 0;

begin
    output <= to_integer(unsigned(address(memory_size -1 downto 2)));         
    process(clk, address, we, wd) begin
        if rising_edge(clk) then
            if we = '1' then
                data(to_integer(unsigned(address(memory_size - 1 downto 2)))) <= wd;
            end if;
        end if;
    end process;
    
    rd<= x"00000000" when we = '1' else data(output);
end architecture;