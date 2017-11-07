LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY Proj IS
PORT ( 
	SW : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	KEY :IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	HEX0,HEX1:OUT STD_LOGIC_VECTOR(0 TO 6));
END Proj;
	ARCHITECTURE Structural OF Proj IS
	COMPONENT FF_T IS
	PORT ( 
	  ENABLE, Clk, Clr, T	 : IN std_logic;
	  Q, Q_n : OUT std_logic);
END COMPONENT;

	COMPONENT Proj IS
	PORT (  SW : IN std_logic_vector (3 DOWNTO 0) ;
	HEX0 : OUT std_logic_vector (0 TO 6)  ) ;
END COMPONENT;
	
	Component seg IS
	PORT (  SW : IN std_logic_vector (3 DOWNTO 0) ;
	HEX0 : OUT std_logic_vector (0 TO 6)  ) ;
END COMPONENT;

	
	SIGNAL VECTOR, VECTOR_n, A: STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	
BEGIN
	
	
	
	
	FF0: FF_T PORT MAP (SW(1),KEY(0),SW(0),SW(1),VECTOR(0),VECTOR_n(0));
	A(0) <= SW(1) AND VECTOR(0);
	FF1: FF_T PORT MAP (SW(1),KEY(0),SW(0),A(0),VECTOR(1),VECTOR_n(1));
	A(1) <= VECTOR(1) AND A(0);
	FF2: FF_T PORT MAP (SW(1),KEY(0),SW(0),A(1),VECTOR(2),VECTOR_n(2));
	A(2) <= VECTOR(2) AND A(1);
	FF3: FF_T PORT MAP (SW(1),KEY(0),SW(0),A(2),VECTOR(3),VECTOR_n(3));
	A(3) <= VECTOR(3) AND A(2);
	FF4: FF_T PORT MAP (SW(1),KEY(0),SW(0),A(3),VECTOR(4),VECTOR_n(4));
	A(4) <= VECTOR(4) AND A(3);
	FF5: FF_T PORT MAP (SW(1),KEY(0),SW(0),A(4),VECTOR(5),VECTOR_n(5));
	A(5) <= VECTOR(5) AND A(4);
	FF6: FF_T PORT MAP (SW(1),KEY(0),SW(0),A(5),VECTOR(6),VECTOR_n(6));
	A(6) <= VECTOR(6) AND A(5);
	FF7: FF_T PORT MAP (SW(1),KEY(0),SW(0),A(6),VECTOR(7),VECTOR_n(7));
	
	H0: seg PORT MAP(VECTOR(3 DOWNTO 0), HEX0);
	
	H1: seg PORT MAP(VECTOR(7 DOWNTO 4), HEX1);

	
END Structural;
	