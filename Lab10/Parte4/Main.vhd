--- Julio Alves Meesquita da Silva -- 156061 --
--- Gabriel Bonani Machado 		  -- 155416 --

LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

ENTITY Main IS
PORT ( 
	CLOCK_50 : IN STD_LOGIC;
	SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
	KEY : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	LEDG : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
	LEDR : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(0 TO 6));
END ENTITY;

ARCHITECTURE Structural OF Main IS

	component i9 IS
		PORT ( 
		Clock, Resetn, Run : IN STD_LOGIC;
		SW: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Done : OUT STD_LOGIC;
		LEDs: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(0 TO 6));
	END component;
	
	SIGNAL Reset : STD_LOGIC; 
	
	BEGIN
	
	Reset <= NOT KEY(0);
	
	i9_50: i9 port map (CLOCK_50, Reset, SW(17), SW(15 downto 0), LEDG(0), LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);

END Structural;

	