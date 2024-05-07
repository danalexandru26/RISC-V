library arithmetic;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_adder_32bit is
end testbench_adder_32bit;

architecture arch of testbench_adder_32bit is
    component adder_word port(
        a: in std_logic_vector (31 downto 0);
        b: in std_logic_vector (31 downto 0);
        carry_in: in std_logic;
        s: out std_logic_vector (31 downto 0);
        carry_out: out std_logic
    );
    end component;

    signal sig_a: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_b: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_carry_in: std_logic := '0';
    signal sig_s: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_carry_out: std_logic := '0';

begin
    sig_a<= x"00000001" after 5ns, x"000f0001" after 15ns;
    sig_b<= x"000f0002" after 7ns;
    sig_carry_in<= '1' after 10ns;


    DUT: adder_word port map(a=> sig_a, b=> sig_b, carry_in=> sig_carry_in, s=> sig_s, carry_out=> sig_carry_out);   
end architecture;