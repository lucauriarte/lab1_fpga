-- ============================================
-- COMPARADOR DE DIRECCIÓN (Genera "soy")
-- Puramente combinacional
-- ============================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparador_dir is
    Port (
        dir_recibida : in  STD_LOGIC_VECTOR(6 downto 0);
        mi_direccion : in  STD_LOGIC_VECTOR(6 downto 0);
        soy          : out STD_LOGIC
    );
end comparador_dir;

architecture Behavioral of comparador_dir is
begin
    -- Comparación simple: soy='1' cuando las direcciones coinciden
    soy <= '1' when (dir_recibida = mi_direccion) else '0';
end Behavioral;