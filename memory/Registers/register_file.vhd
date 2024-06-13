library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity register_file is generic(
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
end register_file;

architecture arch of register_file is
    type matrix is array(word downto 0) of std_logic_vector(word downto 0);

    signal registers: matrix := (
        1=> x"00000001",
        2=> x"00000002",
        5=> x"00000003",
        6=> x"00000004",
        others => x"00000000");

begin
    process(clk) begin
        if rising_edge(clk) then
            if wen = '1' then
                registers(to_integer(unsigned(rs3))) <= wrs3;
            end if;
        end if;
    end process;

    process(rs1, rs2) begin
        if to_integer(unsigned(rs1)) = 0 then 
            rd1 <= x"00000000";
        else rd1 <= registers(to_integer(unsigned(rs1)));
        end if;
        
        if to_integer(unsigned(rs2)) = 0 then
            rd2 <= x"00000000";
        else rd2 <= registers(to_integer(unsigned(rs2)));
        end if;
    end process;
end architecture;