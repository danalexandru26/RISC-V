library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity half_adder is port (
    op_a: in std_logic;
    op_b: in std_logic;
    q: out std_logic;
    carry: out std_logic
);
end half_adder;

architecture arch of half_adder is
    begin
    q <= op_a xor op_b;
    carry <= op_a and op_b;
end arch;
