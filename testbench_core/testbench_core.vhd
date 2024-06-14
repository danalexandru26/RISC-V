library core;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_core is
end testbench_core;


architecture testbench of testbench_core is
    component Core port(
        clk: in std_logic;
        Reset: in std_logic
    );
    end component;
    
    signal sig_clk: std_logic := '0';
    signal sig_Reset: std_logic:= '0';
begin
    sig_clk<= not sig_clk after 1ns;
    sig_Reset<= '1' after 1ns, '0' after 2ns;
    
    DUT: Core port map(clk=> sig_clk, Reset=> sig_Reset);
end architecture;