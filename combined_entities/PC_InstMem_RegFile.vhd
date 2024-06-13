library memory;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity PC_InstMem_RegFile is 
    generic(
        word: integer := 31
    );
    port(
        write_enable: in std_logic;
        sel_decoder: in std_logic;
        clk: in std_logic;
        reset: in std_logic;
        carry: out std_logic
);
end PC_InstMem_RegFile;

architecture arch of PC_InstMem_RegFile is
    component PC_InstMem 
        generic(
            word: integer := 31
        );
        port(
            sel_decoder: in std_logic;
            clk: in std_logic;
            reset: in std_logic;
            instruction: out std_logic_vector(word downto 0)
    );
    end component;

    component register_file generic(
        word: integer := 31;
        mlen: integer := 4
    );

    port(
        clk: in std_logic;
        wen: in std_logic;
        rs1: in std_logic_vector (mlen downto 0);
        rs2: in std_logic_vector (mlen downto 0);
        rs3: in std_logic_vector (mlen downto 0);
        wrs3: in std_logic_vector (word downto 0);
        rd1: out std_logic_vector (word downto 0);
        rd2: out std_logic_vector (word downto 0)
    );
    end component;
    
    component ALU generic (
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
    end component;
    
    signal instruction_out: std_logic_vector(word downto 0);
    signal sig_rd1: std_logic_vector(word downto 0);
    signal sig_rd2: std_logic_vector(word downto 0);
    signal sig_sum: std_logic_vector(word downto 0);
        
begin
    d_PC_InstMem: PC_InstMem port map(clk=> clk, sel_decoder=> sel_decoder,
                                      reset=> reset, instruction=> instruction_out);
    d_register_file: register_file port map(clk=> clk, wen=> write_enable, rs1=>instruction_out(19 downto 15),
                                            rs2=> instruction_out(24 downto 20), rs3=> instruction_out(11 downto 7),
                                            wrs3=> sig_sum, rd1=> sig_rd1, rd2=>sig_rd2);
    d_ALU: ALU port map(a=> sig_rd1, b=> sig_rd2, sel=> "000", s=> sig_sum, carry=> carry);
end architecture;