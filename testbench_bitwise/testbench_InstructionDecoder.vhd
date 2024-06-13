library bitwise;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_InstructionDecoder is
end testbench_InstructionDecoder;

architecture testbench of testbench_InstructionDecoder is
    component InstructionDecoder port(
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
    end component;

    signal sig_Zero: std_logic := '0';
    signal sig_opcode: std_logic_vector(6 downto 0) := "0000000";
    signal sig_funct3: std_logic_vector(2 downto 0) := "000";
    signal sig_funct7: std_logic := '0';
    signal sig_PCSrc: std_logic;
    signal sig_ResultSrc: std_logic;
    signal sig_MemWrite: std_logic;
    signal sig_ALUSrc: std_logic;
    signal sig_ImmSrc: std_logic_vector(1 downto 0);
    signal sig_RegWrite: std_logic;
    signal sig_ALUControl: std_logic_vector(2 downto 0);
begin
    sig_opcode<= "0110011" after 0ns, "0000011" after 12ns, "1100011" after 14ns;
    sig_funct3<= "000" after 2ns, "110" after 6ns, "111" after 8ns, "010" after 10ns;
    sig_funct7<= '1' after 2ns, '0' after 4ns, '1' after 6ns;
    
    DUT: InstructionDecoder port map(zero=> sig_Zero, opcode=> sig_opcode,
                                     funct3=> sig_funct3, funct7=> sig_funct7,
                                     PCSrc=> sig_PCSrc, ResultSrc=> sig_ResultSrc,
                                     MemWrite=> sig_MemWrite, ALUSrc=> sig_ALUSrc,
                                     ImmSrc=> sig_ImmSrc, RegWrite=> sig_RegWrite,
                                     ALUControl=> sig_ALUControl);
end architecture;
