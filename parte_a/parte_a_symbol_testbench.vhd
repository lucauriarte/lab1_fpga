library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parte_a_symbol_testbench is
end parte_a_symbol_testbench;

architecture Behavioral of parte_a_symbol_testbench is

    -- Component declaration
    component parte_a_symbol
        Port (
            A     : in  STD_LOGIC;
            B     : in  STD_LOGIC;
            Cin   : in  STD_LOGIC;
            S     : out STD_LOGIC;
            Cout  : out STD_LOGIC
        );
    end component;

    -- Signals to connect to the UUT (Unit Under Test)
    signal A     : STD_LOGIC := '0';
    signal B     : STD_LOGIC := '0';
    signal Cin   : STD_LOGIC := '0';
    signal S     : STD_LOGIC;
    signal Cout  : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: parte_a_symbol
        Port map (
            A => A,
            B => B,
            Cin => Cin,
            S => S,
            Cout => Cout
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test all input combinations
        A <= '0'; B <= '0'; Cin <= '0'; wait for 100 ns;
        A <= '0'; B <= '0'; Cin <= '1'; wait for 100 ns;
        A <= '0'; B <= '1'; Cin <= '0'; wait for 100 ns;
        A <= '0'; B <= '1'; Cin <= '1'; wait for 100 ns;
        A <= '1'; B <= '0'; Cin <= '0'; wait for 100 ns;
        A <= '1'; B <= '0'; Cin <= '1'; wait for 100 ns;
        A <= '1'; B <= '1'; Cin <= '0'; wait for 100 ns;
        A <= '1'; B <= '1'; Cin <= '1'; wait for 100 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;