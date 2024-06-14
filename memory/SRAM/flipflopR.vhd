library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flipflopR is 
    generic(
        word: integer := 31
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        a: in std_logic_vector(word downto 0):= x"00000000";
        q: out std_logic_vector(word downto 0)
);
end flipflopR;


architecture arch of flipflopR is

begin
    process(clk, reset, a) begin
        if reset = '1' then
            q<= x"00000000";
        elsif rising_edge(clk) then
            q <= a;
        end if;
    end process;
end architecture;