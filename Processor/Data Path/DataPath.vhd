library bitwise;
library arithmetic;
library plexer;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Datapath is generic(
    word: integer := 31
    );
    port(
        clk: in std_logic;
        Reset: in std_logic;
        Instruction: in std_logic_vector(word downto 0);
        ReadData: in std_logic_vector(word downto 0);
        PCSrc: in std_logic;
        ResultSrc: in std_logic;
        ALUSrc: in std_logic;
        ImmSrc: in std_logic_vector(1 downto 0);
        RegWrite: in std_logic;
        ALUControl: in std_logic_vector(2 downto 0);
        Zero: out std_logic;
        PC: out std_logic_vector(word downto 0);
        ALUResult: buffer std_logic_vector(word downto 0);
        WriteData: out std_logic_vector(word downto 0)
    );
end Datapath;

architecture arch of Datapath is
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

    signal ALU_SrcA: std_logic_vector(word downto 0):= x"00000000";
    signal ALU_SrcMux: std_logic_vector(word downto 0):= x"00000000";
    signal ALU_SrcB: std_logic_vector(word downto 0):= x"00000000";
    signal Result_Mux_ALU_DM: std_logic_vector(word downto 0):= x"00000000";
    signal ImmExt_ALU: std_logic_vector(word downto 0):= x"00000000"; -- to add immediate extender

begin
    d_program_counter: program_counter port map(clk=> clk, reset=>Reset, sel_decoder=>PCSrc, PC=>PC);
    
    d_register_file: register_file port map(clk=> clk, wen=> RegWrite, rs1=> Instruction(19 downto 15), rs2=> Instruction(24 downto 20),
                                            rs3=> Instruction(11 downto 7), wrs3=> Result_Mux_ALU_DM , rd1=> ALU_SrcA, rd2=> ALU_SrcMux);

    d_Mux_RegFile_ALU: mux_21 port map(a=> ALU_SrcMux, b=> ImmExt_ALU, sel=> ALUSrc, q=>ALU_SrcB);

    d_ALU: ALU port map(a=> ALU_SrcA, b=> ALU_SrcB, sel=> ALUControl, s=> ALUResult, carry=>Zero); -- to replace carry with zero signal

    d_Mux_ALU_DM: mux_21 port map(a=> ALUResult, b=> ReadData, sel=> ResultSrc, q=> Result_Mux_ALU_DM);
end architecture;