library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_41 is generic(
        word: integer := 31;
        opt: integer := 2
    );

    port(
        a: in std_logic_vector (word downto 0);
        b: in std_logic_vector (word downto 0);
        c: in std_logic_vector (word downto 0);
        d: in std_logic_vector (word downto 0);
        q: out std_logic_vector (word downto 0);
        sel: in std_logic_vector(opt downto 0)
    );
end mux_41;

architecture arch of mux_41 is

begin
    mux: process (a, b, c, d, sel)
    begin
        case sel is
            when "00" =>
                q <= a;
            when "01" =>
                q <= b;
            when "10" =>
                q <= c;
            when "11" =>
                q <= d;
            when others =>
                null;
        end case;
    end process;
end architecture;