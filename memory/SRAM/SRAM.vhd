library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity SRAM is port (
    address: in std_logic_vector(15 downto 0);
    read_sram: in std_logic;
    write_sram: in std_logic;
    write_data_line: in std_logic_vector(31 downto 0);
    read_data_line: out std_logic_vector(31 downto 0)
);
end SRAM;

architecture a_SRAM of SRAM is
    type matrix is array(7 downto 0) of std_logic_vector(31 downto 0);

    signal line_index: integer := 0;
    signal data: matrix := (
        0 => x"00000000",
        1 => x"00000000",
        2 => x"00000000",
        3 => x"00000000",
        4 => x"00000000",
        5 => x"00000000",
        6 => x"00000000",
        7 => x"00000000"
    );
    
    begin
        line_index <= to_integer(unsigned(address(4 downto 2)));

        EXECUTE: 
        process(address, read_sram, write_sram, write_data_line) begin

            if(read_sram = '1') then
                read_data_line <= data(line_index);
            end if;

            if(write_sram = '1') then
                data(line_index) <= write_data_line;
            end if;

        end process;
end a_SRAM;