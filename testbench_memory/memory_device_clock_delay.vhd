library memory;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_device is port(
    address: in std_logic_vector(31 downto 0);
    clk: in std_logic;
    enable: in std_logic;
    wd: in std_logic_vector(31 downto 0);
    rd: out std_logic_vector(31 downto 0);
    we: in std_logic
);
end memory_device;

architecture arch of memory_device is
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

    signal data_in_data_mem: std_logic_vector(31 downto 0);
begin
    d_instruction_memory: instruction_memory port map(clk=> clk, address=> address, rd=> data_in_data_mem);
    d_data_memory: data_memory port map(clk=> clk, we=> we, address=> data_in_data_mem, wd=> wd, rd=> rd);
end architecture;