library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity byte_adder is port(
    x: in std_logic_vector (7 downto 0);
    y: in std_logic_vector (7 downto 0);
    carry_in: in std_logic;
    q: out std_logic_vector (7 downto 0);
    carry_out: out std_logic
);
end byte_adder;

architecture arch of byte_adder is
    component nibble_adder port(
        x: in std_logic_vector (3 downto 0);
        y: in std_logic_vector (3 downto 0);
        q: out std_logic_vector (3 downto 0);
        carry_in: in std_logic;
        carry_out: out std_logic
    );
    end component;

    signal sig_carry_out: std_logic := '0';
begin
    nibble_adder_a: nibble_adder port map(x => x(3 downto 0), y=> y(3 downto 0), carry_in => carry_in, q => q(3 downto 0), carry_out => sig_carry_out);
    nibble_adder_b: nibble_adder port map(x => x(7 downto 4), y=> y(7 downto 4), carry_in => sig_carry_out, q => q(7 downto 4), carry_out => carry_out);
end architecture;