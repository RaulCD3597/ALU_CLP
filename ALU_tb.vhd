----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/06/2020 07:58:17 PM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is

    constant N_tb: natural := 8;

    component ALU is
    generic ( 
        constant N:     natural := 8
        );
    Port (
        a_i, b_i    : in STD_LOGIC_VECTOR(N-1 downto 0); -- entradas
        sel_i       : in STD_LOGIC_VECTOR(3 downto 0); -- selector de funcion
        trig_i      : in STD_LOGIC; -- trigger
        out_o       : out STD_LOGIC_VECTOR(N-1 downto 0); -- salida
        c_o         : out STD_LOGIC -- carry out
        );
    end component;
    
    -- entradas
    signal a_tb     : STD_LOGIC_VECTOR(N_tb-1 downto 0)    := (others => '0');
    signal b_tb     : STD_LOGIC_VECTOR(N_tb-1 downto 0)    := (others => '0');
    signal sel_tb   : STD_LOGIC_VECTOR(3 downto 0)          := (others => '0');
    signal trig_tb  : STD_LOGIC := '1';
    
    -- salidas
    signal o_tb     : STD_LOGIC_VECTOR(N_tb-1 downto 0);
    signal c_tb     : STD_LOGIC;
    
begin

    trig_tb <= not trig_tb after 5 ns;

    a_tb <= std_logic_vector(to_unsigned(70, N_tb)) after 20 ns,
            std_logic_vector(to_unsigned(255, N_tb)) after 70 ns;
            
    b_tb <= std_logic_vector(to_unsigned(2, N_tb)) after 5 ns,
            std_logic_vector(to_unsigned(4, N_tb)) after 30 ns;
            
    sel_tb <= "1101" after 10 ns;
    
    DUT: ALU
        generic map(
            N   => N_tb
            )
        port map(
            a_i     => a_tb,
            b_i     => b_tb,
            sel_i   => sel_tb,
            trig_i  => trig_tb,
            out_o   => o_tb,
            c_o     => c_tb
            );

end Behavioral;
