LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY adder_subtracter IS
	GENERIC (
		N : POSITIVE := 32
	);
	PORT (
		i_a : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
		i_b : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
		i_add_sub : IN STD_LOGIC; -- '0' for add, '1' for subtract
		o_sum : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
		o_carry_out : OUT STD_LOGIC
	);
END adder_subtracter;

ARCHITECTURE structural OF adder_subtracter IS

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
BEGIN
	PROCESS (i_a, i_b, i_add_sub)
	BEGIN
		IF i_add_sub = '0' THEN
			s_b <= i_b;
		ELSE
			s_b <= NOT i_b;
		END IF;
	END PROCESS;

	ADDER : adder_nbit
	PORT MAP(
		i_a => i_a,
		i_b => s_b,
		i_carry_in => i_add_sub,
		o_sum => o_sum,
		o_carry_out => o_carry_out
	);

END structural;
-- BEGIN
--     s_b <= i_b xor (others => i_add_sub);

-- 	ADDER : adder_nbit
-- 	PORT MAP(
-- 		i_a, s_b, 
-- 		i_add_sub, o_sum, 
-- 		o_carry_out
-- 	);
-- END structural;