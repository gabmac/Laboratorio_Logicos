LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
ENTITY Proj IS
PORT ( 
	SW : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	KEY :IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	HEX0,HEX1,HEX2,HEX3:OUT STD_LOGIC_VECTOR(0 TO 6));
END Proj;
	ARCHITECTURE Structural OF Proj IS
	
	
	Component seg IS
	PORT (  SW : IN std_logic_vector (3 DOWNTO 0) ;
	HEX0 : OUT std_logic_vector (0 TO 6)  ) ;
END COMPONENT;
	

component CONT
	PORT
	(
		aclr		: IN STD_LOGIC ;
		clk_en		: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
end component;

	
	SIGNAL VECTOR: STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	
BEGIN
	
	c: CONT PORT MAP(SW(0), SW(1), KEY(0), VECTOR);
	
	H0: seg PORT MAP(VECTOR(3 DOWNTO 0), HEX0);
	
	H1: seg PORT MAP(VECTOR(7 DOWNTO 4), HEX1);
	
	H3: seg PORT MAP(VECTOR(11 DOWNTO 8), HEX2);
	
	H4: seg PORT MAP(VECTOR(15 DOWNTO 12), HEX3);

	
END Structural;
	