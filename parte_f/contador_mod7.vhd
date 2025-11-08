-- ============================================
-- CONTADOR MODULO 7 (Para dirección)
-- Clock = SCL, sin reset
-- Cuenta de 0 a 6 (7 bits), genera fin_dir en cuenta 7
-- ============================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador_mod7 is
    Port (
        SCL     : in  STD_LOGIC;           -- SCL es el clock
        Hab_Dir : in  STD_LOGIC;           -- Habilitación desde FSM
        fin_dir : out STD_LOGIC
    );
end contador_mod7;

architecture Behavioral of contador_mod7 is
    signal contador : unsigned(2 downto 0) := (others => '0');
begin
    process(SCL)
    begin
        if rising_edge(SCL) then
            if Hab_Dir = '0' then
                -- Cuando no está habilitado, reiniciar contador
                contador <= (others => '0');
            else
                -- Contar mientras está habilitado
                if contador = 6 then
                    contador <= (others => '0');  -- Reset después de 7 cuentas
                else
                    contador <= contador + 1;
                end if;
            end if;
        end if;
    end process;
    
    -- Pulso de fin cuando llega a 6 (ha contado 7 bits: 0,1,2,3,4,5,6)
    fin_dir <= '1' when (contador = 6 and Hab_Dir = '1') else '0';
    
end Behavioral;