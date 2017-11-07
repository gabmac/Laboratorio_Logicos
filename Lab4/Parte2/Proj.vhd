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

	
	SIGNAL VECTOR: STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	
BEGIN
	
	PROCESS(KEY(0),SW(0))
	VARIABLE Estado : std_logic_vector(15 DOWNTO 0) := "0000000000000000";

  BEGIN
    IF (SW(0) = '1') THEN
      Estado := "0000000000000000";
    ELSIF ( rising_edge(KEY(0))) THEN
      Estado := Estado + '1';
    END IF;

   VECTOR <= Estado;
END PROCESS;
	
	H0: seg PORT MAP(VECTOR(3 DOWNTO 0), HEX0);
	
	H1: seg PORT MAP(VECTOR(7 DOWNTO 4), HEX1);
	
	H3: seg PORT MAP(VECTOR(11 DOWNTO 8), HEX2);
	
	H4: seg PORT MAP(VECTOR(15 DOWNTO 12), HEX3);

	
END Structural;
	