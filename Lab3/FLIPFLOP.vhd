LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY FLIPFLOP IS
PORT ( 
	CLK,D, RESET : IN STD_LOGIC;
	Q : OUT STD_LOGIC);
END FLIPFLOP;
	ARCHITECTURE Structural OF FLIPFLOP IS
	SIGNAL R_g, S_g, QA, Qb, R_g2, S_g2, QA2, Qb2, QM	: STD_LOGIC ;
	ATTRIBUTE keep : boolean;
	ATTRIBUTE keep of QM, R_g, S_g, QA, Qb, R_g2, S_g2, QA2, Qb2 : SIGNAL IS true;
	
	SIGNAL A : STD_LOGIC;
BEGIN
	
	A <= D AND RESET;
	
	S_g <= A AND (CLK);
	R_g <= (NOT(A) AND CLK) OR NOT RESET;
	QA <= NOT (R_g OR Qb);
	Qb <= NOT (S_g OR QA);
	QM <= QA AND RESET;
	

	
	S_g2 <= QM AND not CLK;
	R_g2 <= (NOT(QM) AND not CLK) OR NOT RESET;
	QA2 <= NOT (R_g2 OR Qb2);
	Qb2 <= NOT (S_g2 OR QA2);
	Q <= QA2 AND RESET;
	
	
END Structural;