LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- Include numeric_std for type conversions

ENTITY add_sub_processor IS
	PORT (
		instruction : IN std_logic_vector(31 DOWNTO 0);
        	clk : IN std_logic
    );
END add_sub_processor;

ARCHITECTURE Behavioral OF add_sub_processor IS

    COMPONENT adder_subtracter IS
        PORT (
            i_a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_add_sub : IN STD_LOGIC;
            o_sum : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_carry_out : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT register_file_3port IS
        PORT (
            clk : IN std_logic; -- Clock signal
            enable : IN std_logic; -- Enable signal
            read_write : IN std_logic; -- 1 = Write, 0 = Read
            address_1 : IN std_logic_vector(4 DOWNTO 0); -- Read address 1
            address_2 : IN std_logic_vector(4 DOWNTO 0); -- Read address 2
            data_address : IN std_logic_vector(4 DOWNTO 0); -- Write address
            data_in : IN std_logic_vector(31 DOWNTO 0); -- Data to write
            data_out_1 : OUT std_logic_vector(31 DOWNTO 0); -- Output of read 1
            data_out_2 : OUT std_logic_vector(31 DOWNTO 0) -- Output of read 2
        );
    END COMPONENT;
	SIGNAL s_a : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL s_b : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL s_o : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL s_add_sub : STD_LOGIC;
BEGIN
	s_add_sub <= NOT instruction(27);
		register_file_inst : register_file_3port
		PORT MAP (
			clk => clk,
			enable => '1',
			read_write => '1',
			address_1 => instruction (25 downto 21), -- Example address for read operation
			address_2 => instruction (20 downto 16), -- Example address for read operation
			data_address => instruction (15 downto 11), -- Example address for write operation
			data_in => s_o, -- Connect output from adder/subtracter
			data_out_1 => s_a, -- Connect to output for read operation 1
			data_out_2 => s_b  -- Connect to output for read operation 2
		);
        adder_subtracter_inst : adder_subtracter
        PORT MAP (
            i_a => s_a,
            i_b => s_b,
            i_add_sub => s_add_sub,
            o_sum => s_o,
            o_carry_out => open
        );

END Behavioral;