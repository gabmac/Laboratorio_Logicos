library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter is
	generic (
		n : natural := 4
	);
	port (
		clock : in STD_LOGIC;
		reset_n : in STD_LOGIC;
		Atual : in STD_LOGIC_VECTOR(n-1 downto 0);
		ValMax : in STD_LOGIC_VECTOR(n-1 downto 0);
		Q : out STD_LOGIC_VECTOR(n-1 downto 0);
		ended : out STD_LOGIC
	); 
end entity;

architecture rtl of counter is

	begin
	PROCESS(clock, reset_n, ValMax, Atual)
		variable value : std_logic_vector(n-1 downto 0);
		
		begin
		if (value >= ValMax) then
			value := (OTHERS => '0');
			ended <= '1';
		elsif (reset_n = '0') then
			value := Atual;
		elsif (rising_edge(clock)) then
			value := value + '1';
			ended <= '0';
		end if;
		
		Q <= value;

	end process;
end rtl;
