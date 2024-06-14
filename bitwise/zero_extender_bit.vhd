library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity zero_extender_bit is generic(
        word: integer := 31
    );

    port(
       bit_in: in std_logic;
       q: out std_logic_vector (word downto 0) 
    );

end zero_extender_bit;

architecture arch of zero_extender_bit is
        constant size: integer := 30;
        signal zero_extend: std_logic_vector (size downto 0) := (others => '0');

begin
    q <= zero_extend & bit_in;
end architecture;