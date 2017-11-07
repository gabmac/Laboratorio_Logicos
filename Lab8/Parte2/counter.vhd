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
		ValMax : in STD_LOGIC_VECTOR(n-1 downto 0);
		ended : out STD_LOGIC
	); 
end entity;

architecture rtl of counter is

	SIGNAL A: STD_LOGIC;
	
	begin
	PROCESS(clock, reset_n, ValMax)
		variable value : std_logic_vector(n-1 downto 0);
		
		begin
		if (reset_n = '0') then
			value := (OTHERS => '0');
			A <= '1';
		elsif (value >= ValMax) then
			A <= '0';
		elsif (rising_edge(clock) AND A = '1') then
			value := value + '1';
			A <= '1';
		end if;
		
	ended <= A;
	end process;
end rtl;
