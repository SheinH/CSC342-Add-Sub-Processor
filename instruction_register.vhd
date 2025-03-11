LIBRARY lpm;
USE lpm.lpm_components.ALL;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY instruction_register IS
    PORT (
        i_clk : IN STD_LOGIC;
        i_reset : IN STD_LOGIC;
        i_data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END instruction_register;

ARCHITECTURE behavioral OF instruction_register IS

    COMPONENT lpm_ff IS
        GENERIC (
            c_data_width : INTEGER := 32
        );
        PORT (
            i_clk : IN STD_LOGIC;
            i_data : IN STD_LOGIC_VECTOR(c_data_width - 1 DOWNTO 0);
            i_async_reset : IN STD_LOGIC;
            o_data : OUT STD_LOGIC_VECTOR(c_data_width - 1 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    lpm_ff_inst : lpm_ff
    GENERIC MAP(
        c_data_width => 32
    )
    PORT MAP(i_clk,i_data_in,i_reset,o_data);

END behavioral;