library arithmetic;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_program_counter is
end testbench_program_counter;

architecture testbench of testbench_program_counter is
    component program_counter 
        generic(
            word: integer := 31
        );
    
        port(
            clk: in std_logic;
            a: in std_logic_vector(word downto 0);
            q: out std_logic_vector(word downto 0)
    );
    end component;
    constant word: integer := 31;

    signal sig_clk: std_logic:= '0';
    signal sig_a: std_logic_vector(word downto 0):= x"00000000";
    signal sig_q: std_logic_vector(word downto 0):= x"00000000";
 begin
    sig_clk<= not sig_clk after 1ns;
    
    DUT: program_counter port map(clk=> sig_clk, a=> sig_a, q=> sig_q);
end architecture;