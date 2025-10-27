library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parte_a is
Port (
        A     : in  STD_LOGIC;
        B     : in  STD_LOGIC;
        Cin   : in  STD_LOGIC;
        S     : out STD_LOGIC;
        Cout  : out STD_LOGIC
    );
end parte_a;

architecture Behavioral of parte_a is
begin
S <= A xor B xor Cin;
Cout <= (B and Cin) or (B and A) or (Cin and A);

end Behavioral;