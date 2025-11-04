-- Testbench para el multiplicador de 2 bits "parte_b"

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_parte_b is
end tb_parte_b;

architecture test of tb_parte_b is

    -- Componente bajo prueba
    component parte_b
        port (
            A0 : in std_logic;
            B0 : in std_logic;
            A1 : in std_logic;
            B1 : in std_logic;
            P0 : out std_logic;
            P1 : out std_logic;
            P2 : out std_logic;
            P3 : out std_logic
        );
    end component;

    -- Señales
    signal A0, A1, B0, B1 : std_logic := '0';
    signal P0, P1, P2, P3 : std_logic;

begin

    -- Instancia del DUT
    uut: parte_b
        port map (
            A0 => A0,
            B0 => B0,
            A1 => A1,
            B1 => B1,
            P0 => P0,
            P1 => P1,
            P2 => P2,
            P3 => P3
        );

    -- Proceso de estímulo
    stim_proc: process
        variable A, B : integer range 0 to 3;
    begin
        for A in 0 to 3 loop
            for B in 0 to 3 loop

                -- Extrae bits de A y B con divisiones/mod
                if (A mod 2) = 1 then
                    A0 <= '1';
                else
                    A0 <= '0';
                end if;

                if (A / 2) = 1 then
                    A1 <= '1';
                else
                    A1 <= '0';
                end if;

                if (B mod 2) = 1 then
                    B0 <= '1';
                else
                    B0 <= '0';
                end if;

                if (B / 2) = 1 then
                    B1 <= '1';
                else
                    B1 <= '0';
                end if;

                wait for 20 ns;

                report "A=" & integer'image(A) &
                       " (" & std_logic'image(A1) & std_logic'image(A0) & ")" &
                       "  B=" & integer'image(B) &
                       " (" & std_logic'image(B1) & std_logic'image(B0) & ")" &
                       "  => P=" & std_logic'image(P3) &
                                   std_logic'image(P2) &
                                   std_logic'image(P1) &
                                   std_logic'image(P0);

            end loop;
        end loop;

        wait;
    end process;

end test;