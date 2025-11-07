LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_textio.all;
USE std.textio.all;

ENTITY tb_parte_e IS
END tb_parte_e;

ARCHITECTURE behavior OF tb_parte_e IS
    -- Declaración del componente
    COMPONENT parte_e
        PORT (
            reset : IN STD_LOGIC := '0';
            clock : IN STD_LOGIC;
            x : IN STD_LOGIC := '0';
            z : OUT STD_LOGIC_VECTOR(0 TO 3)
        );
    END COMPONENT;

    -- Señales de prueba
    SIGNAL reset_tb : STD_LOGIC := '0';
    SIGNAL clock_tb : STD_LOGIC := '0';
    SIGNAL x_tb     : STD_LOGIC := '0';
    SIGNAL z_tb     : STD_LOGIC_VECTOR(0 TO 3);

    CONSTANT clock_period : TIME := 20 ns;
    SIGNAL cycle_counter : INTEGER := 0;
    SIGNAL sim_end : BOOLEAN := FALSE;  -- Señal para terminar la simulación

    -- Función auxiliar para imprimir std_logic_vector
    FUNCTION to_string(slv : std_logic_vector) RETURN string IS
        VARIABLE result : string(1 TO slv'length);
        VARIABLE idx    : INTEGER := 1;
    BEGIN
        FOR i IN slv'range LOOP
            IF slv(i) = '1' THEN
                result(idx) := '1';
            ELSIF slv(i) = '0' THEN
                result(idx) := '0';
            ELSE
                result(idx) := 'X';
            END IF;
            idx := idx + 1;
        END LOOP;
        RETURN result;
    END FUNCTION;

BEGIN
    -- Instancia del DUT
    DUT: parte_e
        PORT MAP (
            reset => reset_tb,
            clock => clock_tb,
            x => x_tb,
            z => z_tb
        );

    -------------------------------------------------------------------
    -- Generador de reloj (se detiene cuando sim_end = TRUE)
    -------------------------------------------------------------------
    clock_process : PROCESS
    BEGIN
        WHILE NOT sim_end LOOP
            clock_tb <= '0';
            WAIT FOR clock_period / 2;
            clock_tb <= '1';
            WAIT FOR clock_period / 2;
        END LOOP;
        WAIT;  -- Detiene el proceso permanentemente
    END PROCESS;

    -------------------------------------------------------------------
    -- Estímulos de prueba
    -------------------------------------------------------------------
    stim_proc: PROCESS
    BEGIN
        WAIT FOR 10 ns;
        report "Iniciando simulación..." severity note;

        -- Reset inicial
        reset_tb <= '1';
        WAIT FOR 40 ns;
        reset_tb <= '0';
        WAIT FOR clock_period;

        -------------------------------------------------------
        -- SECUENCIA A (x=0)
        -- Estados: state1 -> state2 -> state3 -> state4 -> state8 -> state1
        -------------------------------------------------------
        x_tb <= '0';
        report "Ejecutando SECUENCIA A (x=0)" severity note;
        WAIT FOR 10 * clock_period;  -- Esperar ciclo completo + repetición

        -------------------------------------------------------
        -- Cambiar a SECUENCIA B (x=1)
        -- Estados: state1 -> state5 -> state6 -> state3 -> state7 -> state8 -> state1
        -------------------------------------------------------
        x_tb <= '1';
        report "Cambiando a SECUENCIA B (x=1)" severity note;
        WAIT FOR 10 * clock_period;

        -------------------------------------------------------
        -- Volver a SECUENCIA A (x=0)
        -------------------------------------------------------
        x_tb <= '0';
        report "Volviendo a SECUENCIA A (x=0)" severity note;
        WAIT FOR 10 * clock_period;

        -------------------------------------------------------
        -- Reset manual al final
        -------------------------------------------------------
        reset_tb <= '1';
        report "Aplicando reset final..." severity note;
        WAIT FOR 40 ns;
        reset_tb <= '0';

        WAIT FOR 5 * clock_period;

        report "Fin de simulación." severity note;
        sim_end <= TRUE;  -- Señal para detener el reloj
        WAIT;
    END PROCESS;

    -------------------------------------------------------------------
    -- Monitoreo por consola
    -------------------------------------------------------------------
    monitor_proc: PROCESS(clock_tb)
    BEGIN
        IF rising_edge(clock_tb) AND NOT sim_end THEN
            cycle_counter <= cycle_counter + 1;
            report "Ciclo " & integer'image(cycle_counter) &
                   " | x=" & std_logic'image(x_tb) &
                   " | reset=" & std_logic'image(reset_tb) &
                   " | z=" & to_string(z_tb);
        END IF;
    END PROCESS;

END behavior;