library work;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_RAM_64KB is
end tb_RAM_64KB;


architecture testbench of tb_RAM_64KB is
    component RAM_64KB port(
        address: in std_logic_vector(15 downto 0);
        data_dram_out: out std_logic_vector(31 downto 0);
        data_dram_in: in std_logic_vector(31 downto 0);
        read_ram: in std_logic;
        write_ram: in std_Logic;
        ready_ram: out std_logic;
        clk: in std_logic;
        reset: in std_logic
    );
    end component;
    signal address: std_logic_vector(15 downto 0):= x"0000";
    signal data_dram_out: std_logic_vector(31 downto 0) := x"00000000";
    signal data_dram_in: std_logic_vector(31 downto 0) := x"00000000";
    signal read_ram: std_logic := '1';
    signal write_ram: std_Logic := '0';
    signal ready_ram: std_logic := '0';
    signal clk: std_logic := '0';
    signal reset: std_logic := '0';


    begin
    clk <= not clk after 1ns;
    
    address <= x"0001" after 4ns, x"0003" after 11ns, x"0004" after 15ns;
    read_ram <= '0' after 3ns, '1' after 9ns, '1' after 7ns, '0' after 9ns, '1' after 11ns;
    data_dram_in <= x"09080706" after 5ns, x"00000000" after 7ns;
    write_ram <= '1' after 5ns, '0' after 7ns;

    DUT: RAM_64KB port map(address => address, data_dram_out => data_dram_out, data_dram_in => data_dram_in, read_ram => read_ram, write_ram => write_ram, ready_ram => ready_ram, clk => clk, reset => reset);
end architecture;