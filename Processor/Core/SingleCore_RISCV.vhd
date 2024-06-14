library bitwise;
library arithmetic;
library memory;
library plexer;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Core is port(
    clk: in std_logic;
    Reset: in std_logic
);
end Core;

architecture arch of Core is
    component Datapath generic(
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
            ALUResult: out std_logic_vector(word downto 0);
            WriteData: out std_logic_vector(word downto 0)
        );
    end component;

    component Controller generic(
        word: integer := 31
    );
    port(
        Zero: in std_logic;
        Instruction: in std_logic_vector(word downto 0);
        PCSrc: out std_logic;
        ResultSrc: out std_logic;
        MemWrite: out std_logic;
        ALUSrc: out std_logic;
        ImmSrc: out std_logic_vector(1 downto 0);
        RegWrite: out std_logic;
        ALUControl: out std_logic_vector(2 downto 0)     
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

    component data_memory generic(
        word: integer := 31;
        memory_size: integer := 8
    );

    port(
        clk: in std_logic;
        we: in std_logic;
        address: in std_logic_vector (word downto 0);
        wd: in std_logic_vector (word downto 0);
        rd: out std_logic_vector (word downto 0)
    );
    end component;

    signal sig_PCSrc: std_logic := '0';
    signal sig_ResultSrc: std_logic := '0';
    signal sig_MemWrite: std_logic := '0';
    signal sig_ALUSrc: std_logic := '0';
    signal sig_ImmSrc: std_logic_vector(1 downto 0) := "00";
    signal sig_RegWrite: std_logic := '0';
    signal sig_ALUControl: std_logic_vector(2 downto 0) := "000";

    signal sig_Zero: std_logic := '0';

    signal sig_Instruction: std_logic_vector(31 downto 0):= x"00000000";

    signal sig_ReadData: std_logic_vector(31 downto 0):= x"00000000";
    signal sig_PC: std_logic_vector(31 downto 0):= x"00000000";
    signal sig_ALUResult: std_logic_vector(31 downto 0):= x"00000000";
    signal sig_WriteData: std_logic_vector(31 downto 0):= x"00000000";

begin

    d_Controller: Controller port map(Zero=> sig_Zero, Instruction=> sig_Instruction, PCSrc=> sig_PCSrc,
                                      ResultSrc=> sig_ResultSrc, MemWrite => sig_MemWrite, ALUSrc=> sig_ALUSrc,
                                      ImmSrc=> sig_ImmSrc, RegWrite=> sig_RegWrite, ALUControl=> sig_ALUControl);

    d_Datapath: Datapath port map(clk=>clk, Reset=> Reset, Instruction=> sig_Instruction, ReadData=> sig_ReadData,
                                  PCSrc=> sig_PCSrc, ResultSrc=> sig_ResultSrc, ALUSrc=> sig_ALUSrc, ImmSrc=> sig_ImmSrc,
                                  RegWrite=> sig_RegWrite, ALUControl=> sig_ALUControl, Zero=> sig_Zero, PC=> sig_PC,
                                  ALUResult=> sig_ALUResult, WriteData=> sig_WriteData);

    d_Instruction_Memory: instruction_memory port map(clk=> clk, address=> sig_PC, rd=> sig_Instruction);

    d_Data_Memory: data_memory port map(clk=> clk, we=> sig_MemWrite, address=> sig_ALUResult, wd=> sig_WriteData, rd=> sig_ReadData);
end architecture;