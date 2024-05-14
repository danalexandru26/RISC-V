library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity overflow is port(
        a_31: in std_logic;
        b_31: in std_logic;
        s_31: in std_logic;
        sel_0: in std_logic;
        sel_1: in std_logic;
        q: out std_logic
    );
end overflow;

architecture arch of overflow is

    signal sig_overflow: std_logic := '0';
begin
    sig_overflow <= not sel_1 and (a_31 xor b_31 xor sel_0) and (a_31 xor s_31);
    q <= s_31 xor sig_overflow;
end architecture;