library memory;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity PC_InstMem is 
    generic(
        word: integer := 31
    );
    port(
        sel_decoder: in std_logic;
        clk: in std_logic;
        reset: in std_logic;
        instruction: out std_logic_vector(word downto 0)
);
end PC_InstMem;

architecture arch of PC_InstMem is
    component program_counter generic(
        word: integer := 31
        );
        port(
            sel_decoder: in std_logic;
            clk: in std_logic;
            reset:in std_logic;
            PC: buffer std_logic_vector(word downto 0)
        );
    end component;

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

    signal instruction_address: std_logic_vector(word downto 0):= x"00000000";
begin
    d_program_counter: program_counter port map(sel_decoder=> sel_decoder, clk=> clk, reset=> reset, PC=> instruction_address);
    d_instruction_memory: instruction_memory port map(clk=> clk, address=> instruction_address, rd=> instruction);
end architecture;