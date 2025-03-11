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
            op1         : OUT std_logic;
            op2         : OUT std_logic;
            result      : OUT std_logic
        );
    END COMPONENT;

    SIGNAL instruction : std_logic_vector(31 downto 0) := (others => '0');
    SIGNAL clk         : std_logic := '0';
    SIGNAL op1         : std_logic;
    SIGNAL op2         : std_logic;
    SIGNAL result      : std_logic;

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
    END PROCESS clock_process;

    stimulus: PROCESS
    BEGIN
        -- Initialize the instruction signal
        instruction <= "00000000001000100101000000000000";
        WAIT FOR 20 ns;
        
        -- Insert additional stimulus assignments here
        
        WAIT;  -- Wait forever
    END PROCESS stim_proc;

END behavior;