library bitwise;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_zeroExt_bit is
end testbench_zeroExt_bit;

architecture testbemch of testbench_zeroExt_bit is
    component zero_extender_bit is generic(
        size: integer := 30;
        word: integer := 31
    );

    port(
       bit: in std_logic;
       q: out std_logic_vector (word downto 0) 
    );
    end component;

    signal sig_bit: std_logic := '0';
    signal sig_q: std_logic_vector (31 downto 0) := (others => '0');

begin
    sig_bit <= '1' after 5ns, '0' after 15ns;

    DUT: zero_extender_bit port map (bit => sig_bit, q => sig_q);
end architecture;