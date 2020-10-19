----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/06/2020 07:26:31 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
    generic ( 
        constant N:     natural := 4
        );
    Port (
        a_i, b_i    : in STD_LOGIC_VECTOR(N-1 downto 0); -- entradas
        sel_i       : in STD_LOGIC_VECTOR(3 downto 0); -- selector de funcion;
        trig_i      : in STD_LOGIC; -- trigger
        out_o       : out STD_LOGIC_VECTOR(N-1 downto 0); -- salida
        c_o         : out STD_LOGIC -- carry out
        );
end ALU;

architecture Behavioral of ALU is

    signal tmp          : unsigned (N downto 0);
    signal aux          : unsigned (N-1 downto 0);
    signal saux         : signed (N-1 downto 0);

begin

    process(trig_i)
    begin
        if rising_edge(trig_i) then
            case(sel_i) is
                when "0000" => -- suma
                    tmp <= unsigned('0' & a_i) + unsigned('0' & b_i);
                    c_o <= tmp(N);
                when "0001" => -- resta
                    tmp <= unsigned('0' & a_i) - unsigned('0' & b_i);
                    c_o <= tmp(N);
                when "0010" => -- multiplicacion
                    tmp <= to_unsigned(to_integer(unsigned('0' & a_i)) * to_integer(unsigned('0' & b_i)), N+1);
                    c_o <= tmp(N);
                when "0011" => -- division
                    if (unsigned(b_i) /= 0) then
                        tmp <= to_unsigned(to_integer(unsigned('0' & a_i)) / to_integer(unsigned('0' & b_i)), N+1);
                        c_o <= tmp(N);
                    end if;
                when "0100" => -- rotacion logica a la izquierda
                    aux <= unsigned(a_i) sll to_integer(unsigned(b_i));
                    tmp <= unsigned('0' & std_logic_vector(aux));
                    c_o <= '0';
                when "0101" => -- rotacion logica a la derecha
                    aux <= unsigned(a_i) srl to_integer(unsigned(b_i));
                    tmp <= unsigned('0' & std_logic_vector(aux));
                    c_o <= '0';
                when "0110" => -- rotacion aritmetica a la izquierda
                    saux <= shift_left( signed(a_i), to_integer(unsigned(b_i)) );
                    tmp  <= unsigned('0' & std_logic_vector(saux));
                    c_o <= '0';
                when "0111" => -- rotacion aritmetica a la derecha
                    saux <= shift_right( signed(a_i), to_integer(unsigned(b_i)) );
                    tmp  <= unsigned('0' & std_logic_vector(saux));
                    c_o <= '0';
                when "1000" => -- and logico
                    tmp <= unsigned('0' & a_i) and unsigned('0' & b_i);
                    c_o <= '0';
                when "1001" => -- or logico
                    tmp <= unsigned('0' & a_i) or unsigned('0' & b_i);
                    c_o <= '0';
                when "1010" => -- xor logico
                    tmp <= unsigned('0' & a_i) xor unsigned('0' & b_i);
                    c_o <= '0';
                when "1011" => -- nand logico
                    tmp <= unsigned('0' & a_i) nand unsigned('0' & b_i);
                    c_o <= '0';
                when "1100" => -- nor logico
                    tmp <= unsigned('0' & a_i) nor unsigned('0' & b_i);
                    c_o <= '0';
                when "1101" => -- xnor logico
                    tmp <= unsigned('0' & a_i) xnor unsigned('0' & b_i);
                    c_o <= '0';
                when "1110" => -- comparacion igualdad
                    if (a_i = b_i) then
                        tmp <= to_unsigned(1, N+1);
                    else
                        tmp <= to_unsigned(0, N+1);
                    end if;
                    c_o <= '0';
                when "1111" => -- comparacion A > B
                    if (a_i > b_i) then
                        tmp <= to_unsigned(1, N+1);
                    else
                        tmp <= to_unsigned(0, N+1);
                    end if;
                    c_o <= '0';
                when others => --no es un valor correcto
                    tmp <= to_unsigned(0, N+1);
                end case;
            out_o   <= std_logic_vector( tmp(N-1 downto 0) ); -- ALU out
        end if;
    end process;

end Behavioral;
