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
    component arithmetic_engine is generic(
            word: integer := 31
        );
    
        port(
            a: in std_logic_vector (word downto 0);
            b: in std_logic_vector (word downto 0);
            sel: in std_logic;
            carry_out: out std_logic;
            s: out std_logic_vector (word downto 0)
        );
    end component;

    component logic_engine generic(
            word: integer := 31
        );

    port(
        a: in std_logic_vector (word downto 0);
        b: in std_logic_vector (word downto 0);
        q_and: out std_logic_vector (word downto 0);
        q_or: out std_logic_vector (word downto 0);
        q_xor: out std_logic_vector (word downto 0)
    );
    end component;

    component overflow port(
        a_31: in std_logic;
        b_31: in std_logic;
        s_31: in std_logic;
        sel_0: in std_logic;
        sel_1: in std_logic;
        q: out std_logic;
    );
    end component;

    component zero_extender_bit generic(
        word: integer := 31
    );

    port(
       bit: in std_logic;
       q: out std_logic_vector (word downto 0) 
    );
    end component;

    component mux_51 generic(
            word: integer := 31;
            opt: integer := 2
        );
    
        port(
            a: in std_logic_vector (word downto 0);
            b: in std_logic_vector (word downto 0);
            c: in std_logic_vector (word downto 0);
            d: in std_logic_vector (word downto 0);
            e: in std_logic_vector (word downto 0);
            f: in std_logic_vector (word downto 0);
            q: out std_logic_vector (word downto 0);
            sel: in std_logic_vector (opt downto 0)
        );
    end component;


    signal sig_arithmetic_engine_output: std_logic_vector (word downto 0) := (others => '0');

    signal sig_logic_engine_and: std_logic_vector (word downto 0) := (others => '0');
    signal sig_logic_engine_or: std_logic_vector (word downto 0) := (others => '0');
    signal sig_logic_engine_xor: std_logic_vector (word downto 0) := (others => '0');

    signal sig_overflow: std_logic := '0';

    signal sig_zero_extender: std_logic_vector (word downto 0) := (others => '0');


begin
    d_arithmetic_engine: arithmetic_engine port map(a=> a, b=> b, sel=> sel(0), s=> sig_arithmetic_engine_output, carry_out=> carry);
    d_logic_engine: logic_engine port map(a=> a, b=> b, q_and => sig_logic_engine_and, q_or=> sig_logic_engine_or, q_xor=> sig_logic_engine_xor);
    d_overflow: overflow port map(a_31=> a(31), b_31=> b(31), s_31=> sig_arithmetic_engine_output(31), sel_0=> sel(0), sel_1=> sel(1), q=> sig_overflow);
    d_zero_extender: zero_extender_bit port map(bit=> sig_overflow, q=> sig_zero_extender);
    d_mux_51: mux_51 port map(a=> sig_arithmetic_engine_output, b=> sig_arithmetic_engine_output, c=> sig_logic_engine_and, d=> sig_logic_engine_or, e=> sig_logic_engine_xor, f=> sig_zero_extender, sel=> sel, q=> s);
end architecture;

