library memory;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_instruction_memory is
end testbench_instruction_memory;

architecture testbench of testbench_instruction_memory is
    component instruction_memory generic(
        word: integer := 31;
        xlen: integer := 8
    );
    port(
        clk: in std_logic;
        address: in std_logic_vector (word downto 0);
        rd: out std_logic_vector (word downto 0)
    );
    end component;

    constant word: integer := 31;
    constant xlen: integer := 7;

    signal sig_clk: std_logic := '0';
    signal sig_address: std_logic_vector (word downto 0) := x"00000000";
    signal sig_rd: std_logic_vector (word downto 0) := x"00000000";
begin
    sig_clk<= not sig_clk after 1ns;
    sig_address<= x"00000000" after 0ns, x"00000000" after 3ns, x"00000004" after 5ns, x"00000008" after 7ns;

    DUT: instruction_memory port map(clk=> sig_clk, address=> sig_address, rd=> sig_rd);
end architecture;