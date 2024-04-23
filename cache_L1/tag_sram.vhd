library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TAG_SRAM is port(
    write_tag: in std_logic;
    read_tag: in std_logic;
    address: in std_logic_vector(15 downto 0);
    write_data_tag_sram: in std_logic_vector(10 downto 0);
    validity: out std_logic;
    q_tag: out std_logic_vector(10 downto 0)
);
end TAG_SRAM;

architecture a_TAG_SRAM of TAG_SRAM is
    type matrix is array(7 downto 0) of std_logic_vector(11 downto 0);
    
    signal data: matrix := (
        0 => "000000000000",
        1 => "000000000000",
        2 => "000000000000",
        3 => "000000000000",
        4 => "000000000000",
        5 => "000000000000",
        6 => "000000000000",
        7 => "000000000000"
    );
    signal tag_from_address: std_logic_vector(10 downto 0);
    signal index: integer;
    signal tag_validity: std_logic;

    begin
    tag_from_address <= address(15 downto 5);
    index <= to_integer(unsigned(address(4 downto 2)));
    LOGIC:
    process(write_tag, read_tag, write_data_tag_sram) begin

        if(read_tag = '0' and write_tag = '0') then
            validity <= '0';
            q_tag <= "ZZZZZZZZZZZ";
        end if;

        if(read_tag = '1') then
            tag_validity <= data(index)(11);
            if(tag_from_address = data(index)(10 downto 0) and tag_validity = '1') then
                validity <= data(index)(11);     
                q_tag <= data(index)(10 downto 0);   
            else
                validity <= '0';
                q_tag <= "ZZZZZZZZZZZ";
            end if;
        end if;

        if(write_tag = '1') then 
            data(index)(10 downto 0) <= write_data_tag_sram;
            data(index)(11) <= '1';
        end if;

    end process;
end architecture;