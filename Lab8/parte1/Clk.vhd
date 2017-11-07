--		Julio Alves Mesquita da Silva			156061 	--
--		Gabriel Bonani Machado					155416	--

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY Clk IS
PORT ( 
	CLOCK_50: IN STD_LOGIC;
	SEC: OUT STD_LOGIC);
END Clk;


ARCHITECTURE Structural OF Clk IS
	
   BEGIN
	
	PROCESS(CLOCK_50)
	variable C: STD_LOGIC;
	variable Estado : std_logic_vector(28 DOWNTO 0) := "00000000000000000000000000000";

  BEGIN	
	 
  IF ( rising_edge(CLOCK_50)) THEN
      Estado := Estado + '1';
		IF(Estado =  "00010111110101111000010000000") THEN
			Estado := "00000000000000000000000000000";
			C := '1';
		ELSE
			C:= '0';
		END IF;
    END IF;
	 
	SEC <= C;

		
			
	END PROCESS;

	
END Structural;