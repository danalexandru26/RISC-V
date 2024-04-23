library plexer;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_mux21 is
end testbench_mux21;


architecture arch of testbench_mux21 is
    component mux_21 generic(
        word: integer := 31
    );
    
    port(
    a: in std_logic_vector (word downto 0);
    b: in std_logic_vector (word downto 0);
    q: out std_logic_vector (word downto 0);
    sel: in std_logic
    );
    end component;

    signal sig_a: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_b: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_q: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_sel: std_logic := '0';

begin
    sig_a <= x"00000001" after 5ns;
    sig_b <= x"00000002" after 7ns;
    sig_sel <= '1' after 10ns, '0' after 15ns;

    DUT: mux_21 port map(a=> sig_a, b=> sig_b, q=> sig_q, sel=> sig_sel);
end architecture;