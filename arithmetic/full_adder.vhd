library IEEE;
use ieee.std_logic_1164.all;


entity h_or_gate is port(
    x: in std_logic;
    y: in std_logic;
    q: out std_logic
);
end h_or_gate;

architecture arch of h_or_gate is

begin 
    q <= x or y;
end arch;

library arithmetic;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is port(
    op_a: in std_logic;
    op_b: in std_logic;
    carry_in: in std_logic;
    q: out std_logic;
    carry_out: out std_logic
);
end full_adder;

architecture arch of full_adder is
    component half_adder port(
        op_a: in std_logic;
        op_b: in std_logic;
        q: out std_logic;
        carry: out std_logic
    );
    end component;

    component h_or_gate port(
        x: in std_logic;
        y: in std_logic;
        q: out std_logic
    );
    end component;

    signal q_half_adder_a: std_logic := '0';
    signal carry_half_adder_a: std_logic := '0';
    signal carry_half_adder_b: std_logic := '0';

begin
    half_adder_a: half_adder port map(op_a => op_a, op_b => op_b, q => q_half_adder_a, carry => carry_half_adder_a);
    half_adder_b: half_adder port map(op_a => carry_in, op_b => q_half_adder_a, q => q, carry => carry_half_adder_b);
    h_or_gate_a: h_or_gate port map(x => carry_half_adder_a, y => carry_half_adder_b, q => carry_out);
end arch;