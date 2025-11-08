-- ============================================
-- TESTBENCH SIMPLE - Corregido
-- ============================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_parte_f is
end tb_parte_f;

architecture Behavioral of tb_parte_f is

    -- Componente (CORREGIDO para coincidir con la entidad parte_f)
    component parte_f
        Port (
            SCL         : in  STD_LOGIC;
            SDA         : in  STD_LOGIC;
            Dir_esclavo : in  STD_LOGIC_VECTOR(6 downto 0); -- Nombre corregido
            ACK         : out STD_LOGIC;                     -- Nombre corregido
            Datos       : out STD_LOGIC_VECTOR(7 downto 0) -- Nombre corregido
        );
    end component;
    
    -- Señales (Los nombres internos del testbench pueden quedar igual)
    signal SCL          : STD_LOGIC := '0';
    signal SDA          : STD_LOGIC := '1';
    signal mi_direccion : STD_LOGIC_VECTOR(6 downto 0) := "0101010";
    signal dato_out     : STD_LOGIC_VECTOR(7 downto 0);
    signal ack_out      : STD_LOGIC;
    
    -- La señal de reset ya no se usa, pero la dejo para la explicación
    signal reset        : STD_LOGIC := '1'; 
    
    constant PERIOD : time := 10 us;
    
begin
    -- Instanciar DUT (CORREGIDO el port map)
    DUT: parte_f
        port map (
            -- Mapear los puertos de la entidad a las señales del testbench
            SCL         => SCL,
            SDA         => SDA,
            Dir_esclavo => mi_direccion, -- "Dir_esclavo" (DUT) <= "mi_direccion" (TB)
            Datos       => dato_out,     -- "Datos" (DUT) <= "dato_out" (TB)
            ACK         => ack_out       -- "ACK" (DUT) <= "ack_out" (TB)
            -- El puerto "reset" ya no existe en la entidad parte_f
        );
    
    -- Proceso principal de test
    process
    begin
        -- Reset inicial
        -- La lógica de reset se comenta porque la entidad "parte_f"
        -- no tiene un puerto de reset. El reset de la máquina
        -- de estados interna está fijo en '0' dentro del diseño.
        -- reset <= '1';
        -- wait for 100 us;
        -- reset <= '0';
        -- wait for 50 us;
        
        -- ====================================
        -- TRANSACCIÓN I2C COMPLETA
        -- Dirección: 0x2A (0101010)
        -- Dato: 0xA5 (10100101)
        -- ====================================
        
        -- START: SDA = 0
        SDA <= '0';
        wait for PERIOD;
        
        -- Bit 6 de dirección: 0
        SDA <= '0';
        SCL <= '0'; wait for PERIOD/2;
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit 5: 1
        SDA <= '1';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit 4: 0
        SDA <= '0';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit 3: 1
        SDA <= '1';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit 2: 0
        SDA <= '0';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit 1: 1
        SDA <= '1';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit 0: 0
        SDA <= '0';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit R/W: 0 (write)
        SDA <= '0';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- ACK (liberar SDA)
        SDA <= '1';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        wait for 20 us;  -- Pausa para observar ACK
        
        -- ENVIAR DATO: 0xA5 = 10100101
        -- Bit 7: 1
        SDA <= '1';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit 6: 0
        SDA <= '0';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit 5: 1
        SDA <= '1';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit 4: 0
        SDA <= '0';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit 3: 0
        SDA <= '0';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit 2: 1
        SDA <= '1';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit 1: 0
        SDA <= '0';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        -- Bit 0: 1
        SDA <= '1';
        SCL <= '1'; wait for PERIOD/2;
        SCL <= '0'; wait for PERIOD/2;
        
        wait for 50 us;  -- Pausa para observar dato_out
        
        -- STOP
        SDA <= '0';
        wait for PERIOD/2;
        SCL <= '1';
        wait for PERIOD/2;
        SDA <= '1';
        wait for PERIOD;
        
        wait for 200 us;
        
        -- ====================================
        -- SEGUNDA TRANSACCIÓN: Dirección incorrecta
        -- Dirección: 0x55 (1010101)
        -- ====================================
        
        -- START
        SDA <= '0';
        wait for PERIOD;
        
        -- Dirección 1010101
        SDA <= '1'; SCL <= '0'; wait for PERIOD/2; SCL <= '1'; wait for PERIOD/2; SCL <= '0'; wait for PERIOD/2;
        SDA <= '0'; SCL <= '1'; wait for PERIOD/2; SCL <= '0'; wait for PERIOD/2;
        SDA <= '1'; SCL <= '1'; wait for PERIOD/2; SCL <= '0'; wait for PERIOD/2;
        SDA <= '0'; SCL <= '1'; wait for PERIOD/2; SCL <= '0'; wait for PERIOD/2;
        SDA <= '1'; SCL <= '1'; wait for PERIOD/2; SCL <= '0'; wait for PERIOD/2;
        SDA <= '0'; SCL <= '1'; wait for PERIOD/2; SCL <= '0'; wait for PERIOD/2;
        SDA <= '1'; SCL <= '1'; wait for PERIOD/2; SCL <= '0'; wait for PERIOD/2;
        
        -- R/W: 0
        SDA <= '0'; SCL <= '1'; wait for PERIOD/2; SCL <= '0'; wait for PERIOD/2;
        
        -- ACK (no debería generarse)
        SDA <= '1'; SCL <= '1'; wait for PERIOD/2; SCL <= '0'; wait for PERIOD/2;
        
        wait for 50 us;
        
        -- STOP
        SDA <= '0'; wait for PERIOD/2;
        SCL <= '1'; wait for PERIOD/2;
        SDA <= '1'; wait for PERIOD;
        
        wait for 200 us;
        
        report "=== Simulación completada ===";
        wait;
    end process;

end Behavioral;