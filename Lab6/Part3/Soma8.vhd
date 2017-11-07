--- Julio Alves Meesquita da Silva -- 156061 --
--- Gabriel Bonani Machado 		  -- 155416 --

LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

ENTITY Soma8 IS
PORT ( 
	A, B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	Q: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	OVER: OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE Structural OF Soma8 IS


	BEGIN
	PROCESS(A, B)
	
	variable SUM, A1, B1 : std_logic_vector(8 downto 0);

	
	
	BEGIN
	
	A1(7 DOWNTO 0) := A;
	A1(8) := '0';
	
	B1(7 DOWNTO 0) := B;
	B1(8) := '0';
	
	SUM(8) := '0';
	SUM := A1 + B1;
	
	Q <= SUM(7 DOWNTO 0);
	OVER <= SUM(8);
	END PROCESS;
	

END Structural;

	