--- Julio Alves Meesquita da Silva -- 156061 --
--- Gabriel Bonani Machado 		  -- 155416 --

LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

ENTITY Soma8 IS
PORT ( 
	A, B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	SUB : IN STD_LOGIC;
	Q: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	OVER: OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE Structural OF Soma8 IS


	BEGIN
	PROCESS(A, B, SUB)
	
	variable SUM, A1, B1 : std_logic_vector(8 downto 0);
	
	BEGIN
	
	IF (SUB = '1') THEN
		B1(0) := NOT B(0);
		B1(1) := NOT B(1);
		B1(2) := NOT B(2);
		B1(3) := NOT B(3);
		B1(4) := NOT B(4);
		B1(5) := NOT B(5);
		B1(6) := NOT B(6);
		B1(7) := NOT B(7);
		B1(8) := B(7);
		B1 := B1 + '1';
	ELSE 
		B1(7 DOWNTO 0) := B;
		B1(8) := B(7);
	END IF;	
	
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

	