library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pc_instmem is generic(
        word: integer := 31
    );
    port(
        clk: in std_logic;
        branchinst: in std_logic_vector(word downto 0);
        PC: buffer std_logic_vector(word downto 0);
        reset: in std_logic
    );
end pc_instmem;

architecture arch of pc_instmem is
    component instruction_memory generic(
        word: integer := 31;
        xlen: integer := 8
    );
    port(
        clk: in std_logic;
        address: in std_logic_vector (word downto 0);
        rd: out std_logic_vector (word downto 0)
    );
    end component;

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
    
    signal plus4: std_logic_vector(word downto 0);
    signal PCNext: std_logic_vector(word downto 0):= x"00000000";
    signal PCOut: std_logic_vector(word downto 0):= x"00000000";
begin
    d_flipflopR: flipflopR port map(clk=> clk, reset=> reset, a=> PCNext, q=> PC);
    d_PC4: PC4 port map(a=> PC, q=> plus4);
    d_mux21: mux_21 port map(a=> plus4, b=> branchinst, sel=>'0', q=> PCNext);
end architecture;