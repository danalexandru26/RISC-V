library memory;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is generic(
    word: integer := 31
    );
    port(
        sel_decoder: in std_logic;
        clk: in std_logic;
        reset:in std_logic;
        PC: buffer std_logic_vector(word downto 0)
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
    
    component mux_21 generic(
            word: integer := 31
        );
        
        port(
        a: in std_logic_vector (word downto 0);
        b: in std_logic_vector (word downto 0);
        sel: in std_logic;
        q: out std_logic_vector (word downto 0)
    );
    end component;

    signal PCNext: std_logic_vector(word downto 0):= x"00000000";
    signal Plus4: std_logic_vector(word downto 0):= x"00000000";

begin
    d_flipflopR: flipflopR port map(clk=> clk, reset=> reset, a=> PCNext, q=> PC);
    d_PC4: PC4 port map(a=> PC, q=> Plus4);
    d_mux21: mux_21 port map(a=> Plus4, b=> x"00000000", sel=> sel_decoder, q=> PCNext);

end architecture;