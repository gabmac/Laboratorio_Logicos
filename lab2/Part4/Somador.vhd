LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Somador IS
	PORT (Cin : IN STD_LOGIC;
	Saida : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
	Entrada : IN STD_LOGIC_VECTOR(7 DOWNTO 0));
END Somador;

ARCHITECTURE Behavior OF Somador IS
		
		COMPONENT Soma
		PORT (Ci, a , b : IN STD_LOGIC;
		Co, s : OUT STD_LOGIC);
	END COMPONENT;
		
		SIGNAL C : STD_LOGIC_VECTOR(2 DOWNTO 0);
		
		BEGIN
		
		
		S1: Soma PORT MAP(Cin,Entrada(0),Entrada(4),C(0),Saida(0));
		S2: Soma PORT MAP(C(0),Entrada(1),Entrada(5),C(1),Saida(1));
		S3: Soma PORT MAP(C(1),Entrada(2),Entrada(6),C(2),Saida(2));
		S4: Soma PORT MAP(C(2),Entrada(3),Entrada(7),Saida(4),Saida(3));


	
END Behavior;
 	