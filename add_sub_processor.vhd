LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; 

ENTITY add_sub_processor IS
    PORT (
        instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        clk : IN STD_LOGIC;
        op1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        op2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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
            clk : IN STD_LOGIC; -- Clock signal
            enable : IN STD_LOGIC; -- Enable signal
            read_write : IN STD_LOGIC; -- 1 = Write, 0 = Read
            address_1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0); -- Read address 1
            address_2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0); -- Read address 2
            data_address : IN STD_LOGIC_VECTOR(4 DOWNTO 0); -- Write address
            data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Data to write
            data_out_1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- Output of read 1
            data_out_2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- Output of read 2
        );
    END COMPONENT;
    SIGNAL s_a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_b : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_o : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_add_sub : STD_LOGIC;
BEGIN
    s_add_sub <= instruction(1);
    op1 <= s_a;
    op2 <= s_b;
    result <= s_o;
    register_file_inst : register_file_3port
    PORT MAP(
        clk => clk,
        enable => '1',
        read_write => '1',
        address_1 => instruction (25 DOWNTO 21), -- Example address for read operation
        address_2 => instruction (20 DOWNTO 16), -- Example address for read operation
        data_address => instruction (15 DOWNTO 11), -- Example address for write operation
        data_in => s_o, -- Connect output from adder/subtracter
        data_out_1 => s_a, -- Connect to output for read operation 1
        data_out_2 => s_b -- Connect to output for read operation 2
    );
    adder_subtracter_inst : adder_subtracter
    PORT MAP(
        i_a => s_a,
        i_b => s_b,
        i_add_sub => s_add_sub,
        o_sum => s_o,
        o_carry_out => OPEN
    );

END Behavioral;