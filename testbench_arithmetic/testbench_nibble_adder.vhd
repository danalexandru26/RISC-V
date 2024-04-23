library arithmetic;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_nibble_adder is 
end tb_nibble_adder;


architecture arch of tb_nibble_adder is
    component nibble_adder port(
        x: in std_logic_vector (3 downto 0);
        y: in std_logic_vector (3 downto 0);
        q: out std_logic_vector (3 downto 0);
        carry_in: in std_logic;
        carry_out: out std_logic
    );
    end component;

    signal sig_x: std_logic_vector (3 downto 0) := x"0";
    signal sig_y: std_logic_vector (3 downto 0) := x"0";
    signal sig_q: std_logic_vector (3 downto 0) := x"0";
    signal sig_carry_in: std_logic := '0';
    signal sig_carry_out: std_logic := '0';

begin
    sig_x <= x"1" after 5ns, x"4" after 10ns, x"d" after 15ns;
    sig_y <= x"2" after 7ns, x"4" after 20ns, x"7" after 25ns;
    sig_carry_in <= '1' after 12ns, '0' after 17ns;
    DUT: nibble_adder port map(x=> sig_x, y=> sig_y, q=> sig_q, carry_in=> sig_carry_in, carry_out=> sig_carry_out);
end architecture;