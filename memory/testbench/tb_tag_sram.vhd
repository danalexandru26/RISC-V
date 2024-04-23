library work;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_tag_sram is
end tb_tag_sram;

architecture testbench of tb_tag_sram is
    component TAG_SRAM port(
        write_tag: in std_logic;
        read_tag: in std_logic;
        address: in std_logic_vector(15 downto 0);
        write_data_tag_sram: in std_logic_vector(10 downto 0);
        validity: out std_logic;
        q_tag: out std_logic_vector(10 downto 0)
    );
    end component;

    signal write_tag: std_logic := '0';
    signal read_tag: std_logic := '0';
    signal address: std_logic_vector(15 downto 0) := x"0000";
    signal write_data_tag_sram: std_logic_vector(10 downto 0) := "00000000000";
    signal validity: std_logic;
    signal q_tag: std_logic_vector(10 downto 0);

    begin
    read_tag <= '1' after 2ns, '0' after 4ns, '1' after 10ns, '0' after 12ns, '1' after 16ns, '0' after 18ns;
    address <= "1111111111100000" after 5ns, "0111111111100100" after 13ns;
    write_data_tag_sram <= "11111111111" after 5ns, "01111111111" after 13ns;
    write_tag <= '1' after 6ns, '0' after 8ns, '1' after 14ns, '0' after 15ns;
    
    

    DUT: TAG_SRAM port map(write_tag => write_tag, read_tag => read_tag, address => address, write_data_tag_sram => write_data_tag_sram, validity => validity, q_tag => q_tag);
end architecture;