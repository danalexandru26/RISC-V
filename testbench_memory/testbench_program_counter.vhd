library memory;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_program_counter is 
end testbench_program_counter;

architecture testbench of testbench_program_counter is
    component program_counter generic(
        word: integer := 31
        );
        port(
            sel_decoder: in std_logic;
            clk: in std_logic;
            reset:in std_logic;
            PC: buffer std_logic_vector(word downto 0)
        );
    end component;
    constant word: integer := 31;
    
    signal sig_sel_decoder: std_logic := '0';
    signal sig_clk: std_logic := '1';
    signal sig_reset: std_logic := '0';
    signal sig_PC: std_logic_vector(word downto 0);
begin
    sig_clk<= not sig_clk after 1ns;
    sig_reset<= '1' after 1ns, '0' after 2ns;

    DUT: program_counter port map(sel_decoder=> sig_sel_decoder, clk=> sig_clk, reset=> sig_reset, PC=> sig_PC);
end architecture;