library work;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_L1 is
end tb_L1;

architecture testbench of tb_L1 is
    component L1 is port(
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
    end component;

        signal tb_reset: std_logic := '0';
        signal tb_address: std_logic_vector(15 downto 0) := x"0000";
        signal tb_clk: std_logic := '0';
        signal tb_read_cpu: std_logic := '0';
        signal tb_write_cpu: std_logic := '0';
        signal tb_data_cpu_in: std_logic_vector(7 downto 0) := x"00";
        signal tb_data_cpu_out: std_logic_vector(7 downto 0) := x"00";
        
        signal tb_cache_hit: std_logic;
        signal tb_cache_miss: std_logic;


    begin
    tb_clk <= not tb_clk after 1ns;
    tb_address <= x"0000" after 5ns, x"0002" after 55ns, x"0003" after 77ns, x"0004" after 99ns, x"07CC" after 129ns, x"0000" after 180ns, x"0003" after 265ns, x"0506" after 430ns;
    tb_read_cpu <= '1' after 5ns, '0' after 11ns, '0' after 17ns, '0' after 23ns, '1' after 33ns, '0' after 37ns, '1' after 55ns, '0' after 69ns, '1' after 77ns, '0' after 89ns, '1' after 99ns, '0' after 111ns, '1' after 127ns, '0' after 147ns, '1' after 159ns, '0' after 172ns, '1' after 231ns, '0' after 245ns, '1' after 261ns, '0' after 281ns, '1' after 371ns, '0' after 391ns, '1' after 500ns, '0' after 519ns, '1' after 530ns, '0' after 549ns;
    tb_write_cpu <= '1' after 181ns, '0' after 200ns, '1' after 323ns , '0' after 353ns, '1' after 440ns, '0' after 459ns;
    tb_data_cpu_in <= x"02" after 181ns, x"00" after 200ns, x"f4" after 323ns, x"00" after 350ns, x"45" after 420ns;
        
--      tb_address <= x"0000" after 5ns;
--      tb_read_cpu <= '1' after 9ns, '0' after 21ns, '1' after 100ns, '0' after 121ns;
--      tb_write_cpu <=  '1' after 31ns, '0' after 51ns;
--      tb_data_cpu_in <= x"02" after 9ns;
    
    DUT_L1: L1 port map(address => tb_address, clk => tb_clk, reset => tb_reset, read_cpu =>tb_read_cpu, write_cpu =>tb_write_cpu, data_cpu_in => tb_data_cpu_in, data_cpu_out => tb_data_cpu_out, cache_hit => tb_cache_hit, cache_miss => tb_cache_miss);
end testbench; 