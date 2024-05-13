library arithmetic;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_ALU is
end testbench_ALU;

architecture testbench of testbench_ALU is
    component ALU generic (
        word: integer := 31;
        opt: integer := 2
    );

    port(
        a: in std_logic_vector (word downto 0);
        b: in std_logic_vector (word downto 0);
        sel: in std_logic_vector (opt downto 0);
        s: out std_logic_vector (word downto 0);
        carry: out std_logic
    );
    end component;

    constant word: integer := 31;
    constant opt: integer := 2;


    signal sig_a: std_logic_vector (word downto 0) := (others => '0');
    signal sig_b: std_logic_vector (word downto 0) := (others => '0');
    signal sig_sel: std_logic_vector (opt downto 0) := (others => '0');
    signal sig_s: std_logic_vector (word downto 0) := (others => '0');
    signal sig_carry: std_logic;

begin
    sig_a <= x"00000001" after 5ns, x"00000005" after 10ns, x"0000000f" after 22ns, x"70000000" after 30ns;
    sig_b <= x"00000005" after 15ns, x"00001f1f" after 32ns;
    sig_sel <= "001" after 18ns, "000" after 28ns;

    DUT: ALU port map(a=> sig_a, b=> sig_b, sel=> sig_sel, s=> sig_s, carry=> sig_carry);
end architecture;