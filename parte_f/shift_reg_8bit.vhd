-- ============================================
-- REGISTRO DE DESPLAZAMIENTO 8 BITS (Datos)
-- Clock = SCL, sin reset
-- Captura: 1 bit R/W + 8 bits de datos = 9 bits total
-- ============================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg_8bit is
    Port (
        SCL      : in  STD_LOGIC;          -- SCL es el clock
        SDA      : in  STD_LOGIC;          -- Entrada serie I2C
        Hab_Dat  : in  STD_LOGIC;          -- Habilitación desde FSM
        dato_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end shift_reg_8bit;

architecture Behavioral of shift_reg_8bit is
    signal shift_register : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
    process(SCL)
    begin
        if rising_edge(SCL) then
            if Hab_Dat = '1' then
                -- Desplazar e ingresar nuevo bit desde SDA
                shift_register <= shift_register(6 downto 0) & SDA;
            end if;
        end if;
    end process;
    
    dato_out <= shift_register;
    
end Behavioral;