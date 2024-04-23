library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cache_controller is port (
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
end cache_controller;

architecture a_cache_controller of cache_controller is 
    type state is (s_IDLE, s_READ_PREPARE, s_READ_TAG, s_WRITE_PREPARE, s_READ_HIT, s_READ_MISS, s_UPDATE_DATA_READ, s_FINISH_UPDATE, s_GET_CACHE_DATA, s_READ_TAG_WRTIE, s_WRITE_HIT, s_WRITE_MISS, s_WRITE_SRAM_DATA, s_UPDATE_SRAM_DATA, s_GET_MEMORY_DATA);

    signal current_state, next_state: state := s_IDLE;
    signal sig_cache_sram: std_logic_vector(31 downto 0);
    signal sig_tag_sram: std_logic_vector(10 downto 0);
    signal sig_write_cache_sram : std_logic_vector(31 downto 0) := x"00000000";

    begin
    process(clk) begin
        if rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    process(clk)
        variable write_hit_concatenation: std_logic_vector(31 downto 0) := x"11111111";
        variable block_offset: integer := 0;
    begin
        if(rising_edge(clk)) then
            case current_state is
                when s_IDLE =>
                    read_sram <= '0';
                    write_sram <= '0';
                    write_data_sram <= x"00000000";

                    write_tag <= '0';
                    read_tag <= '0';
                    write_data_tag_sram <= "00000000000";
                
                    read_system_memory <= '0';
                    write_system_memory <= '0';
                    data_system_memory_out <= x"00000000";

                    if(read_cpu = '1' and write_cpu ='0') then
                        data_cpu_out <= x"00";
                        cache_miss <= '0';
                        cache_hit <= '0';
                        next_state <= s_READ_PREPARE;
                    end if;

                    if(read_cpu = '0' and write_cpu = '1') then
                        data_cpu_out <= x"00";
                        cache_miss <= '0';
                        cache_hit <= '0';
                        next_state <= s_WRITE_PREPARE;
                    end if;
                
                    when s_READ_PREPARE =>
                    read_tag <= '1';
                    read_sram <= '1';
                    write_tag  <= '0';
                    write_sram <= '0';
           
                    next_state <= s_READ_TAG;
                    
                when s_READ_TAG =>
                    
                    if(validity = '1' and tag_sram_tag /= "ZZZZZZZZZZZ") then
                        next_state <= s_READ_HIT;
                    else
                        next_state <= s_READ_MISS;
                    end if;
                    
                when s_READ_MISS =>
                    cache_miss <= '1';
                    read_system_memory <= '1';

                    if(ready_system_memory = '1') then
                        sig_cache_sram <= data_system_memory_in;
                        read_system_memory <= '0';
                        next_state <= s_UPDATE_DATA_READ;
                    end if;
                
                when s_UPDATE_DATA_READ =>
                    write_data_sram <= sig_cache_sram;
                    write_sram <= '1';

                    write_data_tag_sram <= address(15 downto 5);
                    write_tag <= '1';

                    next_state <= s_FINISH_UPDATE;
                    
                when s_FINISH_UPDATE =>
                    write_sram <= '0';
                    write_tag <= '0';
                    
                    next_state <= s_IDLE;

                when s_READ_HIT =>
                    read_sram <= '1';
                    next_state <= s_GET_CACHE_DATA;
                
                when s_GET_CACHE_DATA =>
                    cache_hit <= '1';
                    sig_cache_sram <= cache_line_sram;
                    
                    block_offset := to_integer(unsigned(address(1 downto 0)));
                    data_cpu_out <= sig_cache_sram((8 * (block_offset + 1)) - 1 downto (8 * block_offset));
                    next_state <= s_IDLE;
                    
                when s_WRITE_PREPARE =>
                    read_tag <= '1';
                    read_sram <= '1';
                    write_tag  <= '0';
                    write_sram <= '0';
                
                    next_state <= s_READ_TAG_WRTIE;
               
               when s_READ_TAG_WRTIE =>
                    if(validity = '1' and tag_sram_tag /= "ZZZZZZZZZZZ") then
                        next_state <= s_WRITE_HIT;
                    else
                        next_state <= s_WRITE_MISS;
                    end if;
              
              when s_WRITE_MISS =>
                    cache_miss <= '1';
                    write_system_memory <= '1';
                    
                    data_system_memory_out <= x"000000" & data_cpu_in;
                    
                    if(ready_system_memory = '1') then
                        write_system_memory <= '0';
                        data_system_memory_out <= x"00000000";
                        
                        next_state <= s_IDLE;
                    end if;
               
                when s_WRITE_HIT  =>    
                    write_system_memory <= '1';
                    data_system_memory_out <= x"000000" & data_cpu_in;
                    
                    if(ready_system_memory = '1') then
                        write_system_memory <= '0';
                        data_system_memory_out <= x"00000000";
                        next_state <= s_GET_MEMORY_DATA;
                    end if;

                when s_GET_MEMORY_DATA =>
                    cache_hit <= '1';
                    read_system_memory <= '1';
                    
                    if(ready_system_memory = '1') then
                        sig_cache_sram <= data_system_memory_in;
                        read_system_memory <= '0';
                        next_state <= s_WRITE_SRAM_DATA;                              
                    end if;                
                    
                when s_WRITE_SRAM_DATA =>
                    write_data_sram <= sig_cache_sram;
                    write_sram <= '1';
                    
                    next_state <= s_FINISH_UPDATE;
                    
                when others =>

            end case;
        end if;
    end process;
end architecture;