LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY adder_subtracter_htike IS
	GENERIC (
		N : POSITIVE := 32
	);
	PORT (
		i_a : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
		i_b : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
		i_add_sub : IN STD_LOGIC;
		o_sum : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
		o_carry_out : OUT STD_LOGIC;
		o_overflow : OUT STD_LOGIC
	);
END adder_subtracter_htike;

ARCHITECTURE structural OF adder_subtracter_htike IS

	COMPONENT adder_nbit IS
		PORT (
			i_a : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
			i_b : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
			i_carry_in : IN STD_LOGIC;
			o_sum : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
			o_carry_out : OUT STD_LOGIC
		);
	END COMPONENT;

	SIGNAL s_b : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
	SIGNAL s_o : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    SIGNAL s_a1 : STD_LOGIC;
    SIGNAL s_b1 : STD_LOGIC;
    SIGNAL s_o1 : STD_LOGIC;
BEGIN
	s_a1 <= i_a(N-1);
	s_b1 <= s_b(N-1);
	s_o1 <= s_o(N-1);
	o_overflow <= (i_a(N - 1) XNOR s_b(N - 1)) AND (i_a(N-1) XOR s_o(N-1));
	s_b <= i_b xor std_logic_vector'(i_b'range => i_add_sub);
	o_sum <= s_o;
	ADDER : adder_nbit
	PORT MAP(
		i_a => i_a,
		i_b => s_b,
		i_carry_in => i_add_sub,
		o_sum => s_o,
		o_carry_out => o_carry_out
	);

END structural;