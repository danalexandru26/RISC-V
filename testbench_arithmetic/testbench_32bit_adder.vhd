library arithmetic;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_adder_32bit is
end testbench_adder_32bit;

architecture arch of testbench_adder_32bit is
    component adder_32bit port(
        x: in std_logic_vector (31 downto 0);
        y: in std_logic_vector (31 downto 0);
        carry_in: in std_logic;
        q: out std_logic_vector (31 downto 0);
        carry_out: out std_logic
    );
    end component;

    signal sig_x: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_y: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_carry_in: std_logic := '0';
    signal sig_q: std_logic_vector (31 downto 0) := x"00000000";
    signal sig_carry_out: std_logic := '0';

begin
    sig_x<= x"00000001" after 5ns, x"000f0001" after 15ns;
    sig_y<= x"000f0002" after 7ns;
    sig_carry_in<= '1' after 10ns;


    DUT: adder_32bit port map(x=> sig_x, y => sig_y, carry_in=> sig_carry_in, q=> sig_q, carry_out=> sig_carry_out);   
end architecture;