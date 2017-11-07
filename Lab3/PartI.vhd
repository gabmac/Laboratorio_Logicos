LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY PartI IS
PORT ( 
	LEDR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	SW : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0));
END PartI;
	ARCHITECTURE Structural OF PartI IS
	SIGNAL R_g1, S_g1, Qa1, Qb1, R_g2, S_g2, Qa2, Qb2, R_g3, S_g3, Qa3, Qb3, R_g4, S_g4, Qa4, Qb4, QM	: STD_LOGIC ;
	ATTRIBUTE keep : boolean;
	ATTRIBUTE keep of QM, R_g1, S_g1, Qa1, Qb1, R_g2, S_g2, Qa2, Qb2, R_g3, S_g3, Qa3, Qb3, R_g4, S_g4, Qa4, Qb4 : SIGNAL IS true;
BEGIN
	--PARTE 1--
	R_g1 <= SW(0) AND KEY(0);
	S_g1 <= SW(1) AND KEY(0);
	Qa1 <= NOT (R_g1 OR Qb1);
	Qb1 <= NOT (S_g1 OR Qa1);
	LEDR(0) <= Qa1;
	
	--PARTE 2--
	
	S_g2 <= SW(2) AND KEY(1);
	R_g2 <= NOT(SW(2)) AND KEY(1);
	Qa2 <= NOT (R_g2 OR Qb2);
	Qb2 <= NOT (S_g2 OR Qa2);
	LEDR(1) <= Qa2;
	
	--PARTE 2,5---
	
	S_g3 <= SW(3) AND NOT (KEY(2));
	R_g3 <= NOT(SW(3)) AND NOT (KEY(2));
	Qa3 <= NOT (R_g3 OR Qb3);
	Qb3 <= NOT (S_g3 OR Qa3);
	QM <= Qa3;
	
	---PARTE 3----
	
	S_g4 <= QM AND KEY(2);
	R_g4 <= NOT(QM) AND KEY(2);
	Qa4 <= NOT (R_g4 OR Qb4);
	Qb4 <= NOT (S_g4 OR Qa4);
	LEDR(2) <= Qa4;
	
	
END Structural;