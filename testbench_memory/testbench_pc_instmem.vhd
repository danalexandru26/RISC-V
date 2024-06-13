library memory;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_pc_instmem is
end testbench_pc_instmem;

architecture testbench of testbench_pc_instmem is
    component pc_instmem generic(
        word: integer := 31
    );
    port(
        clk: in std_logic;
        branchinst: in std_logic_vector(word downto 0);
        PC: buffer std_logic_vector(word downto 0);
        reset: in std_logic
    );
    end component;

    constant word: integer := 31;
    
    signal sig_reset: std_logic:= '0';
    signal sig_clk: std_logic:= '0';
    signal sig_branchinst: std_logic_vector(word downto 0):= x"00000000";
    signal sig_PC: std_logic_vector(word downto 0):= x"00000000";
    signal sig_instruction: std_logic_vector(word downto 0):= x"00000000";
begin
    sig_clk<= not sig_clk after 1ns;
    sig_reset<= '1' after 1ns, '0' after 2ns;
    
    DUT: pc_instmem port map(clk=> sig_clk, branchinst=> sig_branchinst, PC=> sig_PC, reset=> sig_reset);
end architecture;