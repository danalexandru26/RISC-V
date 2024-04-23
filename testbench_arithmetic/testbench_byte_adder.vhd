library arithmetic;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_byte_adder is
end tb_byte_adder;

architecture arch of tb_byte_adder is
    component byte_adder port(
        x: in std_logic_vector (7 downto 0);
        y: in std_logic_vector (7 downto 0);
        carry_in: in std_logic;
        q: out std_logic_vector (7 downto 0);
        carry_out: out std_logic
    );
    end component;

    signal sig_x: std_logic_vector (7 downto 0) := x"00";
    signal sig_y: std_logic_vector (7 downto 0) := x"00";
    signal sig_carry_in: std_logic := '0';
    signal sig_q: std_logic_vector (7 downto 0) := x"00";
    signal sig_carry_out: std_logic := '0';

begin
    sig_x <= x"01" after 5ns, x"ff" after 14ns;
    sig_carry_in <= '1' after 7ns, '0' after 12ns, '1' after 18ns;
    sig_y <= x"05" after 9ns, x"ff" after 16ns;

    DUT: byte_adder port map(x=> sig_x, y=> sig_y, carry_in=> sig_carry_in, q=> sig_q, carry_out=> sig_carry_out);
end architecture;