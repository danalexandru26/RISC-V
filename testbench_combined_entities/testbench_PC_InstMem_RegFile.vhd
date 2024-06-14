library combined_entities;
library memory;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity testbench_PC_InstMem_RegFile is
end testbench_PC_InstMem_RegFile;

architecture arch of testbench_PC_InstMem_RegFile is
    component PC_InstMem_RegFile 
        generic(
            word: integer := 31
        );
        port(
        write_enable: in std_logic;
        sel_decoder: in std_logic;
        clk: in std_logic;
        reset: in std_logic;
        carry: out std_logic
    );
    end component;
    
    signal sig_write_enable: std_logic := '0';
    signal sig_sel_decoder: std_logic := '0';
    signal sig_clk: std_logic := '0';
    signal sig_reset: std_logic := '0';
    signal sig_carry: std_logic;
begin
    sig_clk<= not sig_clk after 1ns;
    sig_reset<= '1' after 1ns, '0' after 2ns;
    sig_write_enable<='1' after 2ns, '0' after 6ns;
    DUT: PC_InstMem_RegFile port map(write_enable=> sig_write_enable, clk=> sig_clk, sel_decoder=> sig_sel_decoder, reset=> sig_reset,
                                     carry=> sig_carry);
end architecture;