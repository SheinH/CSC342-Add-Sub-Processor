LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY register_file_3port IS
	PORT (
		clk : IN STD_LOGIC; -- Clock signal
		enable : IN STD_LOGIC; -- Enable signal
		read_write : IN STD_LOGIC; -- 1 = Write, 0 = Read
		address_1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0); -- Read address 1 (5 bits for 32 registers)
		address_2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0); -- Read address 2
		data_address : IN STD_LOGIC_VECTOR(4 DOWNTO 0); -- Write address (5 bits for 32 registers)
		data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Data to write (32 bits)
		data_out_1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- Output of read 1 (32 bits)
		data_out_2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- Output of read 2 (32 bits)
	);
END ENTITY register_file_3port;

ARCHITECTURE rtl OF register_file_3port IS

	-- Define an array of 32 registers, each 32 bits wide
	TYPE reg_array IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
	-- SIGNAL registers : reg_array := (OTHERS => (OTHERS => '0')); -- Initialize all registers to 0
	SIGNAL registers : reg_array := (
		0 => STD_LOGIC_VECTOR(to_unsigned(0, 32)),
		1 => STD_LOGIC_VECTOR(to_unsigned(1, 32)),
		2 => STD_LOGIC_VECTOR(to_unsigned(2, 32)),
		3 => STD_LOGIC_VECTOR(to_unsigned(3, 32)),
		4 => STD_LOGIC_VECTOR(to_unsigned(4, 32)),
		5 => STD_LOGIC_VECTOR(to_unsigned(5, 32)),
		6 => STD_LOGIC_VECTOR(to_unsigned(6, 32)),
		7 => STD_LOGIC_VECTOR(to_unsigned(7, 32)),
		8 => STD_LOGIC_VECTOR(to_unsigned(8, 32)),
		9 => STD_LOGIC_VECTOR(to_unsigned(9, 32)),
		10 => STD_LOGIC_VECTOR(to_unsigned(10, 32)),
		OTHERS => (OTHERS => '0')
	);

BEGIN
	-- Write operation: on the rising edge of clk, if enable and read_write are high, write data_in into the register indexed by data_address.
	PROCESS (clk)
	BEGIN
		IF rising_edge(clk) THEN
			IF enable = '1' AND read_write = '1' THEN
				registers(to_integer(unsigned(data_address))) <= data_in;
			END IF;
		END IF;
	END PROCESS;

	-- Read operations (combinational): data_out_1 and data_out_2 are assigned the contents of the register indexed by address_1 and address_2, respectively.
	data_out_1 <= registers(to_integer(unsigned(address_1)));
	data_out_2 <= registers(to_integer(unsigned(address_2)));

END ARCHITECTURE rtl;