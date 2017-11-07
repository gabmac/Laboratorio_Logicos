LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY MAIN IS
PORT (KEY: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		SW: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		LEDG: OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
);
	
END MAIN;
	
	
	
ARCHITECTURE Structural OF MAIN IS

	TYPE State_type IS (A, B, C, D, E, F, G, H, I);

	SIGNAL y_Q, y_D : State_type; -- y Q is present state, y D is next state
	SIGNAL w: STD_LOGIC;
		
	BEGIN
	w <= SW(0);
	
	PROCESS (w, y_Q)
	BEGIN
	
	case y_Q IS
		WHEN A =>
			IF(w = '0') THEN y_D <= B;
			ELSE y_D <= F;
			END IF;
		WHEN B =>
			IF (w = '0') THEN y_D <= C;
			ELSE y_D <= F;
			END IF;
		WHEN C =>
			IF (w = '0') THEN y_D <= D;
			ELSE y_D <= F;
			END IF;
		WHEN D  =>
			IF (w = '0') THEN y_D <= E;
			ELSE y_D <= F;
			END IF;
		WHEN E  =>
			IF (w = '0') THEN y_D <= E;
			ELSE y_D <= F;
			END IF;
		WHEN F  =>
			IF (w = '0') THEN y_D <= B;
			ELSE y_D <= G;
			END IF;
		WHEN G =>
			IF (w = '0') THEN y_D <= B;
			ELSE y_D <= H;
			END IF;
		WHEN H  =>
			IF (w = '0') THEN y_D <= B;
			ELSE y_D <= I;
			END IF;
		WHEN I  =>
			IF (w = '0') THEN y_D <= B;
			ELSE y_D <= I;
			END IF;
			
	END CASE;
	END PROCESS;
	
	PROCESS (KEY)
	BEGIN
		
		IF(KEY(1)='0') THEN
			y_Q <= A;
		ELSIF(RISING_EDGE(KEY(0))) THEN 
			y_Q <= y_D;
		END IF;
		
	END PROCESS;
	PROCESS (y_Q)
	BEGIN
	
	case y_Q IS
		WHEN A  =>
			LEDG(0)<='0';
		WHEN B  =>
			LEDG(0)<='0';
		WHEN C  =>
			LEDG(0)<='0';
		WHEN D  =>
			LEDG(0)<='0';
		WHEN E  =>
			LEDG(0)<='1';
		WHEN F  =>
			LEDG(0)<='0';
		WHEN G =>
			LEDG(0)<='0';
		WHEN H  =>
			LEDG(0)<='0';
		WHEN I  =>
			LEDG(0)<='1';
			
	END CASE;
	END PROCESS;
	
END Structural;