library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionDecoder is port(
    Zero: in std_logic;
    opcode: in std_logic_vector(6 downto 0);
    funct3: in std_logic_vector(2 downto 0);
    funct7: in std_logic;
    PCSrc: out std_logic;
    ResultSrc: out std_logic;
    MemWrite: out std_logic;
    ALUSrc: out std_logic;
    ImmSrc: out std_logic_vector(1 downto 0);
    RegWrite: out std_logic;
    ALUControl: out std_logic_vector(2 downto 0)     
);
end InstructionDecoder;

architecture arch of InstructionDecoder is
    component decoder port(
        opcode: in std_logic_vector(6 downto 0);
        Branch: out std_logic;
        ResultSrc: out std_logic;
        MemWrite: out std_logic;
        ALUSrc: out std_logic;
        ImmSrc: out std_logic_vector(1 downto 0);
        RegWrite: out std_logic;
        ALUOpcode: out std_logic_vector(1 downto 0)
    );
    end component;

    component ALUDecoder port(
        opcode: in std_logic_vector(6 downto 0);
        ALUOp: in std_logic_vector(1 downto 0);
        funct3: in std_logic_vector(2 downto 0);
        funct7: in std_logic;
        ALUControl: out std_logic_vector(2 downto 0)
    );
    end component;

    signal sig_ALUOp: std_logic_vector(1 downto 0);

begin
    d_decoder: decoder port map(opcode=> opcode, Branch=>PCSrc,
                                ResultSrc=> ResultSrc, MemWrite=> MemWrite,
                                ALUSrc=> ALUSrc, ImmSrc=> ImmSrc,
                                RegWrite=> RegWrite, ALUOpcode=> sig_ALUOp);
    d_ALUDecoder: ALUDecoder port map(opcode=> opcode, ALUOp=> sig_ALUOp,
                                      funct3 => funct3, funct7=> funct7, ALUControl=> ALUControl);
end architecture;