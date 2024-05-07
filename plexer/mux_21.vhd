library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_21 is generic(
        word: integer := 31
    );
    
    port(
    a: in std_logic_vector (word downto 0);
    b: in std_logic_vector (word downto 0);
    sel: in std_logic;
    q: out std_logic_vector (word downto 0)
);
end mux_21;

architecture arch of mux_21 is

begin
    mux: process (a, b, sel)
    begin
        case sel is
            when '0' =>
                q <= a;
            when '1' =>
                q <= b;
            when others =>
                q <= x"00000000";
        end case;
    end process;
end architecture;