library memory;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_data_memory is
end testbench_data_memory;

architecture testbench of testbench_data_memory is
    component data_memory generic(
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
    end component;

    constant word: integer := 31;
    constant memory_size: integer := 8;
    
    signal sig_clk: std_logic := '0';
    signal sig_we: std_logic := '0';
    signal sig_address: std_logic_vector (word downto 0) := x"00000000";
    signal sig_wd: std_logic_vector (word downto 0) := x"00000000";
    signal sig_rd: std_logic_vector (word downto 0) := x"00000000";
begin
    sig_clk<= not sig_clk after 1ns;
    sig_we<= '1' after 3ns, '0' after 5ns, '1' after 9ns, '0' after 11ns, '1' after 17ns, '0' after 19ns;
    sig_wd<= x"0000000a" after 3ns, x"11111111" after 9ns, x"00000000" after 11ns, x"ffffffff" after 17ns, x"00000000" after 19ns;
    sig_address<= x"00000004" after 3ns, x"00000000" after 5ns, x"00000008" after 9ns, x"00000000" after 11ns, x"00000004" after 13ns, x"00000008" after 15ns, x"0000000C" after 17ns, x"00000000" after 21ns;

    DUT: data_memory port map(clk=> sig_clk, we=> sig_we, address=> sig_address, wd=> sig_wd, rd=> sig_rd);
end architecture;