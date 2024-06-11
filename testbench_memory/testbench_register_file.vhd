library memory;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_register_file is
end testbench_register_file;

architecture testbench of testbench_register_file is
    component register_file generic(
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
    end component;

    constant word: integer := 31;
    constant mlen: integer := 4;

    signal sig_clk: std_logic := '0';
    signal sig_wen: std_logic := '0';
    signal sig_rs1: std_logic_vector (mlen downto 0) := "00000";
    signal sig_rs2: std_logic_vector (mlen downto 0) := "00000";
    signal sig_rs3: std_logic_vector (mlen downto 0) := "00000";
    signal sig_wrs3: std_logic_vector (word downto 0) := x"00000000";
    signal sig_rd1: std_logic_vector (word downto 0) := x"00000000";
    signal sig_rd2: std_logic_vector (word downto 0) := x"00000000";
begin
    sig_clk<= not sig_clk after 1ns;
    
    sig_wen<= '1' after 1ns, '0' after 3ns, '1' after 5ns, '0' after 7ns;
    sig_rs3<= "00001" after 1ns, "00000" after 3ns, "10000" after 5ns, "00000" after 7ns;
    sig_wrs3<= x"ffffffff" after 1ns, x"00000000" after 3ns, x"000f00f1" after 5ns, x"00000000" after 7ns;
    
    sig_rs1<= "00001" after 3ns, "00000" after 5ns, "10000" after 7ns, "00000" after 9ns;
   

    DUT: register_file port map(clk=> sig_clk, wen=> sig_wen, rs1=> sig_rs1, rs2=> sig_rs2, rs3=> sig_rs3, wrs3=> sig_wrs3, rd1=> sig_rd1, rd2=> sig_rd2);
end architecture;