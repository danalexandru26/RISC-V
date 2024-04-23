library plexer;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_mux41 is
end testbench_mux41;

architecture arch of testbench_mux41 is
    component mux_41 generic(
        word: integer := 31;
        opt: integer := 1
    );
    
    port(
        a: in std_logic_vector (word downto 0);
        b: in std_logic_vector (word downto 0);
        c: in std_logic_vector (word downto 0);
        d: in std_logic_vector (word downto 0);
        q: out std_logic_vector (word downto 0);
        sel: in std_logic_vector(opt downto 0)
    );
    end component;

    signal sig_a: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_b: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_c: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_d: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_q: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_sel: std_logic_vector(1 downto 0) := "00";

begin
    sig_a <= x"00000001" after 1ns;
    sig_b <= x"00000002" after 5ns;
    sig_c <= x"00000003" after 10ns;
    sig_d <= x"00000004" after 15ns;
    sig_sel <= "01" after 4ns, "10" after 9ns, "11" after 14ns;

    DUT: mux_41 port map(a=> sig_a, b=> sig_b, c=> sig_c, d=>sig_d, q=> sig_q, sel=>sig_sel);
end architecture;