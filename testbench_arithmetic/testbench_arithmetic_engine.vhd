library arithmetic;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity testbench_arithmetic_engine is
end testbench_arithmetic_engine;

architecture testbench of testbench_arithmetic_engine is
    component arithmetic_engine generic(
        word: integer := 31
    );
    
    port(
        a: in std_logic_vector (word downto 0);
        b: in std_logic_vector (word downto 0);
        sel: in std_logic;
        carry_out: out std_logic;
        s: out std_logic_vector (word downto 0)
    );
    end component;

    signal sig_a: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_b: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_s: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_sel: std_logic := '0';
    signal sig_carry_out: std_logic := '0';

begin
    sig_a <= x"00000001" after 5ns, x"00000007" after 10ns;
    sig_b <= x"00000003" after 7ns, x"00000007" after 15ns, x"0000000a" after 23ns;
    sig_sel <= '1' after 13ns, '0' after 18ns, '1' after 20ns;

    DUT: arithmetic_engine port map(a=> sig_a, b=> sig_b, sel=> sig_sel, carry_out=> sig_carry_out, s=> sig_s);
end architecture;