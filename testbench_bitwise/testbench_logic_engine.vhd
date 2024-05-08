library bitwise;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_logic_engine is
end testbench_logic_engine;

architecture testbench of testbench_logic_engine is
    component logic_engine is generic(
        word: integer := 31
    );

    port(
        a: in std_logic_vector (word downto 0);
        b: in std_logic_vector (word downto 0);
        q_and: out std_logic_vector (word downto 0);
        q_or: out std_logic_vector (word downto 0);
        q_xor: out std_logic_vector (word downto 0)
    );
    end component;

    constant word: integer := 31;

    signal sig_a: std_logic_vector (word downto 0) := (others => '0');
    signal sig_b: std_logic_vector (word downto 0) := (others => '0');
    signal sig_q_and: std_logic_vector (word downto 0) := (others => '0');
    signal sig_q_or: std_logic_vector (word downto 0) := (others => '0');
    signal sig_q_xor: std_logic_vector (word downto 0) := (others => '0');

begin
    sig_a <= x"00000001" after 2ns;
    sig_b <= x"00000001" after 4ns, x"11111111" after 6ns;
    
    DUT: logic_engine port map(a=> sig_a, b=> sig_b, q_and=> sig_q_and, q_or=> sig_q_or, q_xor=> sig_q_xor);
end architecture;