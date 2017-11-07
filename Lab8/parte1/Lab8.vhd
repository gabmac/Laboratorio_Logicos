LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY Lab8 IS
PORT (SW: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		CLOCK_50: IN STD_LOGIC;
		HEX0,HEX1: OUT STD_LOGIC_VECTOR(0 TO 6);
		LEDR: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
);
	
END Lab8;
	
	
	
ARCHITECTURE Structural OF Lab8 IS


COMPONENT Clk IS
PORT ( 
	CLOCK_50: IN STD_LOGIC;
	SEC: OUT STD_LOGIC);
END COMPONENT;

COMPONENT counter is
	generic (
		n : natural := 4
	);
	port (
		clock : in STD_LOGIC;
		reset_n : in STD_LOGIC;
		ValMax : in STD_LOGIC_VECTOR(n-1 downto 0);
		ended : out STD_LOGIC
	); 
end COMPONENT;

	TYPE State_type IS (A, B, C, D);

	SIGNAL y_Q : State_type := A; -- y Q is present state, y D is next state
	SIGNAL y_D : State_type := A; -- y Q is present state, y D is next state
	SIGNAL w, Tmin,Tmax,Tam,CLOCK,rst: STD_LOGIC;

		
	BEGIN
	w <= SW(8);
	
	CLK50: Clk port map (CLOCK_50, CLOCK);
	
	C1: counter
		generic map( 3 )
		port map (CLOCK,rst,"101",Tmax);
	LEDR(0)<= Tmax;
		
	C2: counter
		generic map( 3 )
		port map (CLOCK,rst,"101",Tmin);
	LEDR(1)<= Tmin;
		
	C3: counter
		generic map( 1 )
		port map (CLOCK,rst,"1",Tam);
	LEDR(2)<= Tam;
	
	PROCESS (w, y_Q,Tmin,Tmax,Tam)
	BEGIN
	
	case y_Q IS
		WHEN A =>
			IF(w = '0' OR Tmin ='1' ) THEN 
				y_D <= A;
				rst <= '1';
			ELSE 
				y_D <= B;
				rst <= '0';
			END IF;
		WHEN B =>
			IF (Tam = '1') THEN 
				y_D <= B;
				rst <= '1';
			ELSE 
				y_D <= C;
				rst <= '0';
			END IF;
		WHEN C =>
			IF (w = '1' AND Tmax ='1') THEN 
				y_D <= C;
				rst <= '1';
			ELSE 
				y_D <= D;
				rst <= '0';			
			END IF;
		WHEN D  =>
			IF (Tam = '1') THEN 
				y_D <= D;
				rst <= '1';
			ELSE 
				y_D <= A;
				rst <= '0';			
			END IF;
			
	END CASE;
	END PROCESS;
	
	process(y_D, CLOCK)
	begin
	
	if(rising_edge(CLOCK)) THEN
		y_Q <= y_D;
	end if;
	
	end process;
	
	PROCESS (y_Q)
	BEGIN
	
	case y_Q IS
		WHEN A  =>
			HEX0 <= "1100010";
			HEX1 <= "0011100";
		WHEN B  =>
			HEX0 <= "1111110";
			HEX1 <= "0011100";
		WHEN C  =>
			HEX0 <= "0011100";
			HEX1 <= "1100010";
		WHEN D  =>
			HEX0 <= "0011100";
			HEX1 <= "1111110";
			
	END CASE;
	END PROCESS;
	
END Structural;