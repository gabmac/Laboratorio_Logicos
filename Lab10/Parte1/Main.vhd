--- Julio Alves Meesquita da Silva -- 156061 --
--- Gabriel Bonani Machado 		  -- 155416 --

LIBRARY ieee;
use ieee.std_logic_1164.all;

ENTITY Main IS
	PORT ( 
		SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		KEY : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(17 DOWNTO 0));
END ENTITY;

ARCHITECTURE Structural OF Main IS

	component proc IS
		PORT ( DIN : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Resetn, Clock, Run : IN STD_LOGIC;
			Done : BUFFER STD_LOGIC;
			BusWires : BUFFER STD_LOGIC_VECTOR(15 DOWNTO 0));
	END component;

	BEGIN
	
	Processaor: proc PORT MAP (SW(15 DOWNTO 0), KEY(0), KEY(1), SW(17), LEDR(17), LEDR(15 DOWNTO 0));
	

END Structural;

	