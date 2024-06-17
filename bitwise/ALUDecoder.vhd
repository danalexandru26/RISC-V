library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUDecoder is generic(
        word: integer := 31
    );
    port(
        opcode: in std_logic_vector(6 downto 0);
        ALUOp: in std_logic_vector(1 downto 0);
        funct3: in std_logic_vector(2 downto 0);
        funct7: in std_logic;
        ALUControl: out std_logic_vector(2 downto 0)
    );
end ALUDecoder;

architecture arch of ALUDecoder  is 
    signal output: std_logic_vector(2 downto 0);
begin
    process(opcode, ALUOp, funct3, funct7)
        variable concat: std_logic_vector(1 downto 0);
    begin
        case ALUOp is
            when "00" =>
                output <= "000";
            when "01" =>
                output <= "001";
            when "10" =>
                case funct3 is
                    when "000" =>
                        concat:= opcode(5) & funct7;
                        if concat = "11" then
                            output <= "001";
                        else
                            output <= "000";
                        end if;
                    when "010" =>
                        output <= "101";
                    when "110" =>
                        output <= "011";
                    when "111" =>
                        output <= "010";
                    when others =>
                        output <= "---";
                end case;
             when others =>
                output <= "---";            
            end case;
    end process;
    ALUControl <= output;
end architecture;
