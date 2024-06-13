library combined_entities;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_PC_InstMem is 
end testbench_PC_InstMem;

architecture testbench of testbench_PC_InstMem is
    component PC_InstMem 
        generic(
            word: integer := 31
        );
        port(
            sel_decoder: in std_logic;
            clk: in std_logic;
            reset: in std_logic;
            instruction: out std_logic_vector(word downto 0)
    );
    end component;
    
    constant word: integer := 31;

    signal sig_sel_decoder: std_logic := '0';
    signal sig_clk: std_logic := '0';
    signal sig_reset: std_logic := '0';
    signal sig_instruction: std_logic_vector(word downto 0);

begin
    sig_clk<= not sig_clk after 1ns;
    sig_reset<= '1' after 1ns, '0' after 2ns;

    DUT: PC_InstMem port map(sel_decoder=> sig_sel_decoder, clk=> sig_clk, reset=> sig_reset, instruction=> sig_instruction);
end architecture;