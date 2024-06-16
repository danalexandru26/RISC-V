library plexer;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ImmediateExtender is generic (
        word: integer := 31
    );
    port(
        immediatein: in std_logic_vector(31 downto 7);
        immsrc: in std_logic_vector(1 downto 0);
        immout: out std_logic_vector(word downto 0)
    );
end ImmediateExtender;

architecture arch of ImmediateExtender is



begin
    process(immediatein, immsrc) begin
        case immsrc is
            when "00"=>
                immout<= (31 downto 12 => immediatein(31)) &  immediatein(31 downto 20);
            when "01"=>
                immout<= (31 downto 12 => immediatein(31)) & immediatein(31 downto 25) & immediatein(11 downto 7);
            when "10"=>

            when "11"=>

            when others=>
                immout<= x"--------";
        end case;
    end process;
end architecture;