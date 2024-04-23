library arithmetic;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_full_adder is
end tb_full_adder;

architecture arch of tb_full_adder is
    component full_adder port(
        op_a: in std_logic;
        op_b: in std_logic;
        carry_in: in std_logic;
        q: out std_logic;
        carry_out: out std_logic
    );
    end component;

    signal sig_op_a: std_logic := '0';
    signal sig_op_b: std_logic := '0';
    signal sig_carry_in: std_logic := '0';
    signal sig_q: std_logic := '0';
    signal sig_carry_out: std_logic := '0';

begin
    sig_op_a <= '1' after 6ns, '0' after 12ns, '1' after 19ns;
    sig_op_b <= '0' after ns, '1' after 8ns, '0' after 18ns;
    sig_carry_in <= '1' after 5ns, '0' after 6ns, '1' after 8ns, '0' after 10ns, '1' after 14ns;

    DUT: full_adder port map(op_a=> sig_op_a, op_b=> sig_op_b, carry_in=> sig_carry_in, q=> sig_q, carry_out=> sig_carry_out);
end architecture;