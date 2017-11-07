library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter is
	generic (
		n : natural := 16
	);
	port (
		clock ,reset_n, incr_pc : in std_logic;
		PCin : in std_logic;
		Input : in STD_LOGIC_VECTOR(n-1 downto 0);
		count : out STD_LOGIC_VECTOR(n-1 downto 0)
	); 
end entity;

architecture rtl of counter is

	
	begin
	PROCESS(clock, reset_n, incr_pc, PCin, Input)
		variable value : std_logic_vector(n-1 downto 0):= (OTHERS => '0') ;
		
		begin
		if (reset_n = '1') then
			value := (OTHERS => '0');
		elsif (rising_edge(clock)) then
			if (PCin = '1') then
				value := Input;
			elsif (incr_pc = '1') then
				value := value + '1';
			end if;

		end if;
		
	count <= value;
	end process;
end rtl;
