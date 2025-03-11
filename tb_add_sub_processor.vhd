LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_add_sub_processor IS
-- Testbench has no ports
END tb_add_sub_processor;

ARCHITECTURE behavior OF tb_add_sub_processor IS

    COMPONENT add_sub_processor
        PORT(
            instruction : IN  std_logic_vector(31 downto 0);
            clk         : IN  std_logic;
            op1         : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            op2         : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            result      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL instruction : std_logic_vector(31 downto 0) := (others => '0');
    SIGNAL clk         : std_logic := '0';
    SIGNAL op1         : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL op2         : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL result      : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

    uut: add_sub_processor
        PORT MAP (
            instruction => instruction,
            clk         => clk,
            op1         => op1,
            op2         => op2,
            result      => result
        );

    clock : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        WAIT FOR 10 ns;
    END PROCESS clock;

    stimulus: PROCESS
    BEGIN
        -- Initialize the instruction signal
        instruction <= "00000000001000100101000000000000";
        WAIT FOR 20 ns;
        instruction <= "00000000001000100101000000010000";
        WAIT FOR 20 ns;
        
        -- Insert additional stimulus assignments here
        
        WAIT;  -- Wait forever
    END PROCESS stimulus;

END behavior;