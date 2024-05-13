library arithmetic;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_ALU is
end testbench_ALU;

architecture testbench of testbench_ALU is
    component ALU is generic (
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
    constant sopt: integer := 2


    signal sig_a: std_logic_vector (word downto 0);
    signal sig_b: std_logic_vector (word downto 0);
    signal sig_sel: std_logic_vector (opt downto 0);
    signal sig_s: std_logic_vector (word downto 0);
    signal sig_carry: std_logic

begin

end architecture;