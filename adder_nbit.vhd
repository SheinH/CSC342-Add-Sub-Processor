LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY adder_nbit_htike IS
    GENERIC (
        N : POSITIVE := 32
    );
    PORT (
        i_a : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        i_b : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        i_carry_in : IN STD_LOGIC;
        o_sum : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        o_carry_out : OUT STD_LOGIC
    );
END adder_nbit_htike;

ARCHITECTURE structural OF adder_nbit_htike IS

    COMPONENT full_adder IS
        Port ( A : in  std_logic;
           B : in  std_logic;
			  CarryIn: in std_logic;
           Sum : out  std_logic;
           CarryOut : out  std_logic);
    END COMPONENT;

    SIGNAL s_carry : STD_LOGIC_VECTOR(0 TO N) := (OTHERS => '0');

BEGIN

    s_carry(0) <= i_carry_in;

    adder_gen : FOR i IN 0 TO N - 1 GENERATE
        FA : full_adder
        PORT MAP(
            A => i_a(i),
            B => i_b(i),
            CarryIn => s_carry(i),
            Sum => o_sum(i),
            CarryOut => s_carry(i + 1)
        );
    END GENERATE adder_gen;

    o_carry_out <= s_carry(N);

END structural;