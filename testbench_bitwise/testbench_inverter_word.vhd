library bitwise;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_inverter is
end testbench_inverter;

architecture testbench of testbench_inverter is
    component inverter_word generic(
        word: integer := 31
        );
        port(
            a: in std_logic_vector (word downto 0);
            q: out std_logic_vector (word downto 0)
        );
    end component;

    signal sig_a: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_q: std_logic_vector (31 downto 0) := x"00000000";

begin
    sig_a <= x"00000001" after 5ns, x"10001010" after 10ns;

    DUT: inverter_word port map(a=> sig_a, q=> sig_q);
end architecture;