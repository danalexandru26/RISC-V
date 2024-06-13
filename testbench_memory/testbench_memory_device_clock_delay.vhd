library memory;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_memory_device is
end testbench_memory_device;

architecture testbench of testbench_memory_device is
    component memory_device port(
        address: in std_logic_vector(31 downto 0);
        clk: in std_logic;
        enable: in std_logic;
        wd: in std_logic_vector(31 downto 0);
        rd: out std_logic_vector(31 downto 0);
        we: in std_logic
    );
    end component;

    signal sig_address: std_logic_vector(31 downto 0) := x"00000000";
    signal sig_clk: std_logic := '0';
    signal sig_enable: std_logic:= '0';
    signal sig_wd: std_logic_vector(31 downto 0) := x"00000000";
    signal sig_rd: std_logic_vector(31 downto 0) := x"00000000";
    signal sig_we: std_logic:= '0';
begin
    sig_clk<= not sig_clk after 1ns;
    sig_address<= x"00000004" after 2ns, x"00000008" after 4ns;

    DUT: memory_device port map(address=> sig_address, clk=> sig_clk, enable=> sig_enable, wd=> sig_wd, rd=> sig_rd, we=> sig_we);
end architecture;