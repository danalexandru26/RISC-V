library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM_64KB is port(
    address: in std_logic_vector(15 downto 0);
    data_dram_out: out std_logic_vector(31 downto 0);
    data_dram_in: in std_logic_vector(31 downto 0);
    read_ram: in std_logic;
    write_ram: in std_Logic;
    ready_ram: out std_logic;
    clk: in std_logic;
    reset: in std_logic
);
end RAM_64KB;

architecture a_RAM_64KB of RAM_64KB is 
    type matrix is array(65535 downto 0) of std_logic_vector(7 downto 0);

    signal data: matrix := (
        0 => x"01",
        1 => x"02",
        2 => x"03",
        3 => x"04",
        4=> x"f0",
        5=> x"f1",
        6=> x"f2",
        7=> x"f3",
        1996 => x"a0",
        1997 => x"b0",
        1998 => x"c0",
        1999 => x"d0",
        others => x"00"
    );
    signal tagline: std_logic_vector(13 downto 0);
    signal address_int: integer;

    begin
        tagline <= address(15 downto 2);

    process(address, data_dram_in, clk, reset, read_ram, write_ram)
        variable concatenated_address: std_logic_vector(15 downto 0) := x"0000";
        variable current_block: std_logic_vector(1 downto 0) := "00";
        variable memory_block: std_logic_vector(31 downto 0);
        variable index: integer := 0;
        begin
            if(rising_edge(clk)) then
                if(reset /= '1') then
                    if(read_ram = '1') then
                        for i in 0 to 3 loop
                            concatenated_address := tagline & current_block;
                            index := to_integer(unsigned(concatenated_address));
                        
                            memory_block((8 * (i+1) -1) downto 8 * i) := data(index);
                            current_block := std_logic_vector((unsigned(current_block)) + 1);
                        end loop;
                            data_dram_out <= memory_block;
                            ready_ram <= '1';
                            current_block := "00";
                            memory_block := x"00000000";
                        else
                            ready_ram <= '0';
                            data_dram_out <= x"00000000";
                        end if;
                    if(write_ram = '1') then
                            ready_ram <= '1';
                            index := to_integer(unsigned(address));
                        
                            data(index) <= data_dram_in(7 downto 0);
   
                            current_block := "00";
                            memory_block := x"00000000";
                    end if;
                    if(read_ram = '0' and write_ram = '0') then
                        data_dram_out <= x"00000000";
                        ready_ram <= '0';
                    end if;
                else
                    data <= (others => (others=>'0'));
                end if;
            end if;
    end process;
    
end architecture; 