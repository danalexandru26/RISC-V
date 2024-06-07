library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity logic_engine is generic(
        word: integer := 31
    );

    port(
        a: in std_logic_vector (word downto 0);
        b: in std_logic_vector (word downto 0);
        q_and: out std_logic_vector (word downto 0);
        q_or: out std_logic_vector (word downto 0);
        q_xor: out std_logic_vector (word downto 0)
    );
end logic_engine;

architecture arch of logic_engine is
    component and_32bit generic(
        word: integer := 31
    );
    
    port(
        x: in std_logic_vector (word downto 0);
        y: in std_logic_vector (word downto 0);
        q: out std_logic_vector (word downto 0)
    );
    end component;

    component or_32bit generic(
        word: integer := 31
    );
    
    port(
        x: in std_logic_vector (word downto 0);
        y: in std_logic_vector (word downto 0);
        q: out std_logic_vector (word downto 0)
    );
    end component;

    component xor_word generic(
        word: integer := 31
    );

    port(
        x: in std_logic_vector (word downto 0);
        y: in std_logic_vector (word downto 0);
        q: out std_logic_vector (word downto 0)
    );
    end component;

begin
    d_and_32bit: and_32bit port map(x=> a, y=> b, q=> q_and);
    d_or_32bit: or_32bit port map(x=> a, y=> b, q=> q_or);
    d_xor_32bit: xor_word port map(x=> a, y=> b, q=> q_xor);
end architecture;




