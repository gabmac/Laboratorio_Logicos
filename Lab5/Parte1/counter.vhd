library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity counter is
	generic (
		n : natural := 4
	);
	port (
		clock : in STD_LOGIC;
		reset_n : in STD_LOGIC;
		ValMax : in STD_LOGIC_VECTOR(n-1 downto 0);
		Q : out STD_LOGIC_VECTOR(n-1 downto 0)
	);
end entity;

architecture rtl of counter is

	begin
	PROCESS(clock, reset_n, ValMax)
		variable value : std_logic_vector(n-1 downto 0);
		
		begin
		if (reset_n = '0' OR (value = ValMax)) then
			value := (OTHERS => '0');
		elsif (rising_edge(clock)) then
			value := value + '1';
		end if;
		
		Q <= value;

	end process;
end rtl;
