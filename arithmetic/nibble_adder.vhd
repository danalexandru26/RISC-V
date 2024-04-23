library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nibble_adder is port(
    x: in std_logic_vector (3 downto 0);
    y: in std_logic_vector (3 downto 0);
    q: out std_logic_vector (3 downto 0);
    carry_in: in std_logic;
    carry_out: out std_logic
);
end nibble_adder;

architecture arch of nibble_adder is
    component full_adder port(
        op_a: in std_logic;
        op_b: in std_logic;
        carry_in: in std_logic;
        q: out std_logic;
        carry_out: out std_logic
    );
    end component;

    signal sig_carry_a: std_logic := '0';
    signal sig_carry_b: std_logic := '0';
    signal sig_carry_c: std_logic := '0';

begin
    full_adder_a: full_adder port map(op_a => x(0), op_b => y(0), carry_in => carry_in, q=>q(0), carry_out => sig_carry_a);
    full_adder_b: full_adder port map(op_a => x(1), op_b => y(1), carry_in => sig_carry_a, q=>q(1), carry_out => sig_carry_b);
    full_adder_c: full_adder port map(op_a => x(2), op_b => y(2), carry_in => sig_carry_b, q=>q(2), carry_out => sig_carry_c);
    full_adder_d: full_adder port map(op_a => x(3), op_b => y(3), carry_in => sig_carry_c, q=>q(3), carry_out => carry_out);
end architecture;