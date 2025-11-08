-- ============================================
-- REGISTRO DE DESPLAZAMIENTO 7 BITS (Dirección)
-- Clock = SCL, sin reset
-- ============================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg_7bit is
    Port (
        SCL      : in  STD_LOGIC;          -- SCL es el clock
        SDA      : in  STD_LOGIC;          -- Entrada serie I2C
        Hab_Dir  : in  STD_LOGIC;          -- Habilitación desde FSM
        dir_out  : out STD_LOGIC_VECTOR(6 downto 0)
    );
end shift_reg_7bit;

architecture Behavioral of shift_reg_7bit is
    signal shift_register : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
begin
    process(SCL)
    begin
        if rising_edge(SCL) then
            if Hab_Dir = '1' then
                -- Desplazar e ingresar nuevo bit desde SDA
                shift_register <= shift_register(5 downto 0) & SDA;
            end if;
        end if;
    end process;
    
    dir_out <= shift_register;
    
end Behavioral;