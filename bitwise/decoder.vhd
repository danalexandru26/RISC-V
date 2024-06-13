library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is port(
        opcode: in std_logic_vector(6 downto 0);
        Branch: out std_logic;
        ResultSrc: out std_logic;
        MemWrite: out std_logic;
        ALUSrc: out std_logic;
        ImmSrc: out std_logic_vector(1 downto 0);
        RegWrite: out std_logic;
        ALUOpcode: out std_logic_vector(1 downto 0)
    );
end decoder;

architecture arch of decoder is 
    signal output: std_logic_vector(8 downto 0);
begin
    process(opcode) begin
        case opcode is
            when "0000011" => --lw
            output <= "100101000";
            when "0100011" =>  -- sw
                output<= "00111-000";
            when "0110011" => -- R-type
                output<= "1--000010";
            when "1100011" => -- beq
                output<= "01000-101";   
            when others =>
                output<= "---------";     
            end case;
    end process;
    (RegWrite, ImmSrc(1), ImmSrc(0), ALUSrc, MemWrite, ResultSrc, Branch, ALUOpcode(1), ALUOpcode(0)) <= output;
end architecture;