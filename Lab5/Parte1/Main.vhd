 library ieee;
use ieee.std_logic_1164.all;

entity Main is
	port (
		SW : in STD_LOGIC_VECTOR (7 DOWNTO 0);
		KEY: in STD_LOGIC_VECTOR(1 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
end entity;

architecture arc of Main is

	SIGNAL Q: STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	COMPONENT counter is 
		generic (
			n : natural := 4
		);
		port ( 
			clock : in STD_LOGIC;
			reset_n : in STD_LOGIC;
			ValMax : in STD_LOGIC_VECTOR(n-1 downto 0);
			Q : out STD_LOGIC_VECTOR(n-1 downto 0)
			);
		end component;
	
	begin
		
	eight_bit: counter
		generic map( 8 )
		port map (KEY(0), KEY(1), SW, LEDR);
	
end arc;
