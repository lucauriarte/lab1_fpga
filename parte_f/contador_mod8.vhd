-- ============================================
-- CONTADOR MODULO 8 (Para R/W + datos)
-- Clock = SCL, sin reset
-- Cuenta 9 bits total: 1 R/W + 8 datos
-- Genera fin_dato cuando completa los 9 bits
-- ============================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador_mod8 is
    Port (
        SCL      : in  STD_LOGIC;          -- SCL es el clock
        Hab_Dat  : in  STD_LOGIC;          -- Habilitación desde FSM
        fin_dato : out STD_LOGIC
    );
end contador_mod8;

architecture Behavioral of contador_mod8 is
    signal contador : unsigned(3 downto 0) := (others => '0');
begin
    process(SCL)
    begin
        if rising_edge(SCL) then
            if Hab_Dat = '0' then
                -- Cuando no está habilitado, reiniciar contador
                contador <= (others => '0');
            else
                -- Contar mientras está habilitado
                if contador = 8 then
                    contador <= (others => '0');  -- Reset después de 9 cuentas
                else
                    contador <= contador + 1;
                end if;
            end if;
        end if;
    end process;
    
    -- Pulso de fin cuando llega a 8 (ha contado 9 bits: 0-8)
    fin_dato <= '1' when (contador = 8 and Hab_Dat = '1') else '0';
    
end Behavioral;