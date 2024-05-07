library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arithmetic_engine is generic(
    word: integer := 31
    );

    port(
        a: in std_logic_vector (word downto 0);
        b: in std_logic_vector (word downto 0);
        sel: in std_logic;
        carry_out: out std_logic;
        s: out std_logic_vector (word downto 0)
    );
end arithmetic_engine;

architecture arch of arithmetic_engine is 
    component adder_word port(
        a: in std_logic_vector (31 downto 0);
        b: in std_logic_vector (31 downto 0);
        carry_in: in std_logic;
        s: out std_logic_vector (31 downto 0);
        carry_out: out std_logic
    );
    end component;

    component inverter_word generic(
        word: integer := 31
    );

    port(
        a: in std_logic_vector (word downto 0);
        q: out std_logic_vector (word downto 0)
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

    signal inverter_output: std_logic_vector (31 downto 0) := x"00000000";
    signal multiplexed_output: std_logic_vector (31 downto 0) := x"00000000";

begin
    d_inverter_word: inverter_word port map(a=> b, q=> inverter_output);
    d_mux_21: mux_21 port map(a=> b, b=> inverter_output, sel=> sel, q=> multiplexed_output);
    d_adder_word: adder_word port map(a=> a, b=> multiplexed_output, carry_in=> sel, s=>s, carry_out=> carry_out);
end architecture;