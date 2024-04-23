library work;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity L1 is port(
    address: in std_logic_vector(15 downto 0);
    clk: in std_logic;
    reset: in std_logic;
    read_cpu: in std_logic;
    write_cpu: in std_logic;
    data_cpu_in: in std_logic_vector(7 downto 0);
    data_cpu_out: out std_logic_vector(7 downto 0);
    
    cache_hit: out std_logic;
    cache_miss: out std_logic
);
end L1;

architecture a_L1 of L1 is
    component SRAM port (
        address: in std_logic_vector(15 downto 0);
        read_sram: in std_logic;
        write_sram: in std_logic;
        write_data_line: in std_logic_vector(31 downto 0);
        read_data_line: out std_logic_vector(31 downto 0)
    );
    end component;

    component TAG_SRAM port(
        write_tag: in std_logic;
        read_tag: in std_logic;
        address: in std_logic_vector(15 downto 0);
        write_data_tag_sram: in std_logic_vector(10 downto 0);
        validity: out std_logic;
        q_tag: out std_logic_vector(10 downto 0)
    );
    end component;

    component RAM_64KB port(
        address: in std_logic_vector(15 downto 0);
        data_dram_out: out std_logic_vector(31 downto 0);
        data_dram_in: in std_logic_vector(31 downto 0);
        read_ram: in std_logic;
        write_ram: in std_Logic;
        ready_ram: out std_logic;
        clk: in std_logic;
        reset: in std_logic
    );
    end component;

    component cache_controller port (
        clk: in std_logic;
        read_cpu: in std_logic;
        write_cpu: in std_logic;
        data_cpu_in: in std_logic_vector(7 downto 0);
        data_cpu_out: out std_logic_vector(7 downto 0);
        cache_miss: out std_logic;
        cache_hit: out std_logic;
        address: in std_logic_vector(15 downto 0);
    
        --from and to SRAM
        cache_line_sram: in std_logic_vector(31 downto 0);
        read_sram: out std_logic;
        write_sram: out std_logic;
        write_data_sram: out std_logic_vector(31 downto 0);
    
        --from and to TAG SRAM
        validity: in std_logic;
        tag_sram_tag: in std_logic_vector(10 downto 0);
        write_tag: out std_logic;
        read_tag: out std_logic;
        write_data_tag_sram: out std_logic_vector(10 downto 0);
    
        --from and to system memory
        data_system_memory_in: in std_logic_vector(31 downto 0);
        data_system_memory_out: out std_logic_vector(31 downto 0);
        read_system_memory: out std_logic;
        write_system_memory: out std_logic;
        ready_system_memory: in std_logic
    );
    end component;
    
    --SRAM
    signal s_read_sram: std_logic;
    signal s_write_sram: std_logic;
    signal s_write_data_sram: std_logic_vector (31 downto 0);
    signal s_cache_line: std_logic_vector (31 downto 0);
    
    --TAG SRAM
    signal s_write_data_tag_sram: std_logic_vector(10 downto 0);
    signal s_write_tag_sram: std_logic;
    signal s_read_tag_sram: std_logic;
    signal s_tag_validity: std_logic;
    signal s_tag_out: std_logic_vector(10 downto 0);
    
    signal s_ready: std_logic;
    signal s_data_system_memory_out: std_logic_vector(31 downto 0);
    signal s_data_system_memory_in: std_logic_vector(31 downto 0);
    signal s_read_system_memory: std_logic;
    signal s_write_system_memory: std_logic;
    
    begin
    DUT_SRAM: SRAM port map(address => address, read_sram => s_read_sram, write_sram => s_write_sram, write_data_line => s_write_data_sram, read_data_line => s_cache_line);
    DUT_TAG_SRAM: TAG_SRAM port map(write_tag => s_write_tag_sram, read_tag => s_read_tag_sram, address => address, write_data_tag_sram => s_write_data_tag_sram, validity => s_tag_validity, q_tag => s_tag_out);
    DUT_RAM_64KB: RAM_64KB port map(address => address, data_dram_out => s_data_system_memory_out, data_dram_in => s_data_system_memory_in, read_ram => s_read_system_memory, write_ram => s_write_system_memory, ready_ram => s_ready, clk => clk, reset => reset);
    DUT_CACHE_CONTROLLER: cache_controller port map (clk => clk, read_cpu => read_cpu, write_cpu => write_cpu, data_cpu_in => data_cpu_in, data_cpu_out => data_cpu_out, cache_miss => cache_miss, cache_hit => cache_hit, address => address, cache_line_sram => s_cache_line, read_sram => s_read_sram, write_sram => s_write_sram, write_data_sram => s_write_data_sram, validity => s_tag_validity, tag_sram_tag => s_tag_out, write_tag => s_write_tag_sram, read_tag => s_read_tag_sram, write_data_tag_sram => s_write_data_tag_sram, data_system_memory_in => s_data_system_memory_out, data_system_memory_out => s_data_system_memory_in, read_system_memory => s_read_system_memory, write_system_memory => s_write_system_memory, ready_system_memory=> s_ready);
end architecture;