library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity program_counter is 
    generic(
        word: integer :=31
    );

    port(
        clk: in std_logic;
        a: in std_logic_vector(word downto 0);
        q: out std_logic_vector(word downto 0)
);
end program_counter;

architecture arch of program_counter is
    signal current: std_logic_vector(word downto 0):= x"00000000";

begin
    process(clk,  a) begin
        if rising_edge(clk) then
            current <= std_logic_vector(unsigned(a) + 1); 
        end if;
    end process;
    
    q<= current;
end architecture;