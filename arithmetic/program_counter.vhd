library arithmetic;
library memory;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity program_counter is 
    generic(
        word: integer :=31
    );
    port(
        clk: in std_logic;
        q: out std_logic_vector(word downto 0)
);
end program_counter;

architecture arch of program_counter is
    component flipflopR 
        generic(
            word: integer := 31
        );
        port(
            clk: in std_logic;
            reset: in std_logic;
            a: in std_logic_vector(word downto 0);
            q: out std_logic_vector(word downto 0)
    );
    end component;

    component PC4 generic(
        word: integer := 31
    );
    port(
        a: in std_logic_vector(word downto 0);
        q: out std_logic_vector(word downto 0)
    );
    end component;

    signal plus4: std_logic_vector(word downto 0):= x"00000000";
    signal currentCount: std_logic_vector(word downto 0):= x"00000000";

begin

    d_flipflopR: flipflopR port map(clk=> clk, reset=> '0', a=>plus4, q=> currentCount);
    d_PC4: PC4 port map(a=> currentCount, q=> plus4);
end architecture;