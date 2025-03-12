LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_add_sub_processor_htike IS
END tb_add_sub_processor_htike;

ARCHITECTURE behavior OF tb_add_sub_processor_htike IS

    COMPONENT add_sub_processor
        PORT (
            instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            clk : IN STD_LOGIC;
            op1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            op2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            overflow: OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL instruction : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL op1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL op2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_addr1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_addr2 : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_addr3 : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL opcode : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL add_or_sub : STD_LOGIC;
    SIGNAL overflow : STD_LOGIC;
    SIGNAL opcode_str : string(1 to 4);

BEGIN

    opcode <= instruction(31 DOWNTO 26);
    s_addr1 <= instruction(25 DOWNTO 21);
    s_addr2 <= instruction(20 DOWNTO 16);
    s_addr3 <= instruction(15 DOWNTO 11);
    add_or_sub <= instruction(27);
    uut : add_sub_processor
    PORT MAP(
        instruction => instruction,
        clk => clk,
        op1 => op1,
        op2 => op2,
        result => result,
        overflow => overflow
    );

    clock : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        WAIT FOR 10 ns;
    END PROCESS clock;

    opcode_decode : PROCESS(opcode)
    BEGIN
        if opcode = "100000" then
            opcode_str <= "ADD ";
        elsif opcode = "100010" then
            opcode_str <= "SUB ";
        elsif opcode = "100001" then
            opcode_str <= "ADDU";
        elsif opcode = "100011" then
            opcode_str <= "SUBU";
        else
            opcode_str <= "XXXX";
        END IF;
    END PROCESS opcode_decode;

    stimulus : PROCESS
    BEGIN
        instruction <= "10000000001000101010000000000000";
        WAIT FOR 20 ns;
        instruction <= "10001001010101001010100000000000";
        WAIT FOR 20 ns;
        instruction <= "10000101100000011011000000000000";
        WAIT FOR 20 ns;
        instruction <= "10000001101010111100000000000000";
        WAIT FOR 20 ns;
        instruction <= "10001001101000011100100000000000";
        WAIT FOR 20 ns;
        instruction <= "10001101101000011100100000000000";
        WAIT FOR 20 ns;

        WAIT;
    END PROCESS stimulus;

END behavior;