--- Julio Alves Meesquita da Silva -- 156061 --
--- Gabriel Bonani Machado 		  -- 155416 --

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Mux IS
	PORT ( 
		R0,R1,R2,R3,R4,R5,R6,R7,G,Din : IN STD_LOGIC_VECTOR(15 downto 0);
		Rcontrol : IN STD_LOGIC_VECTOR(0 to 7);
		Dcontrol, Gcontrol : IN STD_LOGIC;
		Q : OUT STD_LOGIC_VECTOR(15 downto 0));
END Mux;

ARCHITECTURE Structural OF Mux IS
	
	BEGIN
	PROCESS(Rcontrol, Gcontrol, Dcontrol, Din)
	
	BEGIN
	IF(Rcontrol(0) = '1') THEN
		Q <= R0;
	ELSIF(Rcontrol(1) = '1') THEN
		Q <= R1;
	ELSIF(Rcontrol(2) = '1') THEN
		Q <= R2;
	ELSIF(Rcontrol(3) = '1') THEN
		Q <= R3;
	ELSIF(Rcontrol(4) = '1') THEN
		Q <= R4;
	ELSIF(Rcontrol(5) = '1') THEN
		Q <= R5;
	ELSIF(Rcontrol(6) = '1') THEN
		Q <= R6;
	ELSIF(Rcontrol(7) = '1') THEN
		Q <= R7;
	ELSIF(Gcontrol = '1') THEN
		Q <= G;
	ELSIF(Dcontrol = '1') THEN
		Q <= Din;
	ELSE
		Q <= "0000000000000000";
	END IF;
	END PROCESS;
		
	
END Structural;