library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is generic (
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

end ALU;

architecture arch of ALU is

    component or_32bit port(
        x: in std_logic_vector (31 downto 0);
        y: in std_logic_vector (31 downto 0);
        q: out std_logic_vector (31 downto 0)
    );
    end component;

    component and_32bit port(
        x: in std_logic_vector (31 downto 0);
        y: in std_logic_vector (31 downto 0);
        q: out std_logic_vector (31 downto 0)
    );
    end component;

begin



end architecture;

