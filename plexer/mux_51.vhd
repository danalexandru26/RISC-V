library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_51 is generic(
    word: integer := 31;
    opt: integer := 3
    );

    port(
        a: in std_logic_vector (word downto 0);
        b: in std_logic_vector (word downto 0);
        c: in std_logic_vector (word downto 0);
        d: in std_logic_vector (word downto 0);
        e: in std_logic_vector (word downto 0);
        q: out std_logic_vector (word downto 0);
        sel: in std_logic_vector(opt downto 0)
    );
end mux_51;

architecture arch of mux_51 is

begin
    mux : process (a, b, c, d, e, sel)
    begin
        case sel is
            when "000" =>
                q <= a;
            when "001" =>
                q <= b;
            when "010" =>
                q <= c;
            when "011" =>
                q <= d;
            when "100" =>
                q <= e; 
            when others =>
                null;
        end case;
    end process;
end architecture;