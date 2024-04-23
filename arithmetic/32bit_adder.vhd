library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_32bit is port(
    x: in std_logic_vector (31 downto 0);
    y: in std_logic_vector (31 downto 0);
    carry_in: in std_logic;
    q: out std_logic_vector (31 downto 0);
    carry_out: out std_logic
);
end adder_32bit;

architecture arch of adder_32bit is
    component byte_adder port(
        x: in std_logic_vector (7 downto 0);
        y: in std_logic_vector (7 downto 0);
        carry_in: in std_logic;
        q: out std_logic_vector (7 downto 0);
        carry_out: out std_logic
    );
    end component;

    signal sig_carry_out_a: std_logic := '0';
    signal sig_carry_out_b: std_logic := '0';
    signal sig_carry_out_c: std_logic := '0';

begin
    byte_adder_a: byte_adder port map(x=> x(7 downto 0), y=> y(7 downto 0), carry_in =>carry_in, q=> q(7 downto 0), carry_out => sig_carry_out_a);
    byte_adder_b: byte_adder port map(x=> x(15 downto 8), y=> y(15 downto 8), carry_in =>sig_carry_out_a, q=> q(15 downto 8), carry_out => sig_carry_out_b);
    byte_adder_c: byte_adder port map(x=> x(23 downto 16), y=> y(23 downto 16), carry_in =>sig_carry_out_b, q=> q(23 downto 16), carry_out => sig_carry_out_c);
    byte_adder_d: byte_adder port map(x=> x(31 downto 24), y=> y(31 downto 24), carry_in =>sig_carry_out_c, q=> q(31 downto 24), carry_out => carry_out);
end architecture;