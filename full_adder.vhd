LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY full_adder IS
    PORT (
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        CarryIn : IN STD_LOGIC;
        Sum : OUT STD_LOGIC;
        CarryOut : OUT STD_LOGIC);
END full_adder;

ARCHITECTURE dataflow OF full_adder IS
BEGIN

    Sum <= A XOR B XOR CarryIn;
    CarryOut <= (A AND B) OR ((A XOR B) AND CarryIn);

END dataflow;