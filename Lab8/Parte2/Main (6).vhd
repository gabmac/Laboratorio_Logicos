--- Gabriel Bonani Machado 155416
--- Julio Alves Mesquita 156061

LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY Main IS
PORT (SW: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		CLOCK_50: IN STD_LOGIC;
		HEX0,HEX1,HEX2,HEX3: OUT STD_LOGIC_VECTOR(0 TO 6);
		LEDR: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
);
	
END Main;
	
	
	
ARCHITECTURE Structural OF Main IS


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

	TYPE State_type IS (A, B, C, D, E, F, G);

	SIGNAL y_Q : State_type := A; -- y Q is present state, y D is next state
	SIGNAL y_D : State_type := A; -- y Q is present state, y D is next state
	SIGNAL w_e, w_d, Tmin,Tmax,Tam,CLOCK,rst, rst_m: STD_LOGIC;

		
	BEGIN
	w_e <= SW(9);
	w_d <= SW(8);
	
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
	
	PROCESS (w_e, w_d, y_Q,Tmin,Tmax,Tam)
	BEGIN
	
	case y_Q IS
		--- Inicio
		WHEN A =>
			IF((w_d = '0' and w_e = '0') OR Tmin ='1' ) THEN 
				y_D <= A;
				rst_m <= '1';
			ELSIF(w_e = '1') THEN
				y_D <= E;
				rst_m <= '0';
			ELSIF(w_d = '1') THEN
				y_D <= B;
				rst_m <= '0';
			END IF;
		--- Libera curva para a direita
		WHEN B =>
			IF (Tam = '1') THEN 
				y_D <= B;
				rst_m <= '1';
			ELSE 
				y_D <= C;
				rst_m <= '0';
			END IF;
		WHEN C =>
			IF (w_d = '1' AND Tmax ='1') THEN 
				y_D <= C;
				rst_m <= '1';
			ELSE 
				y_D <= D;
				rst_m <= '0';			
			END IF;
		WHEN D  =>
			IF (Tam = '1') THEN 
				y_D <= D;
				rst_m <= '1';
			ELSE 
				y_D <= A;
				rst_m <= '0';			
			END IF;
		--- Libera curva para a esquerda e direita
		WHEN E =>
			IF (Tam = '1') THEN 
				y_D <= E;
				rst_m <= '1';
			ELSE 
				y_D <= F;
				rst_m <= '0';
			END IF;
		WHEN F =>
			IF (w_e = '1' AND Tmax ='1') THEN 
				y_D <= F;
				rst_m <= '1';
			ELSE 
				y_D <= G;
				rst_m <= '0';			
			END IF;
		WHEN G  =>
			IF (Tam = '1') THEN 
				y_D <= G;
				rst_m <= '1';
			ELSE 
				y_D <= A;
				rst_m <= '0';			
			END IF;
			
	END CASE;
	END PROCESS;
	
	process(y_D, CLOCK)
	begin
	
	--- se w_e:
	--- 	A > E > F > G > A
	--- se w_d:
	--- 	A > B > C > D > A
				
	
	if(rising_edge(CLOCK)) THEN
		y_Q <= y_D;
		rst <= rst_m;

	end if;
	
	end process;
	
	PROCESS (y_Q)
	BEGIN
	
	case y_Q IS
		WHEN A  =>
			HEX0 <= "1100010";
			HEX1 <= "1100010";
			HEX2 <= "0011100";
			HEX3 <= "0011100";
		WHEN B  =>
			HEX0 <= "1100010";
			HEX1 <= "1111110";
			HEX2 <= "0011100";
			HEX3 <= "0011100";
		WHEN C  =>
			HEX0 <= "1100010";
			HEX1 <= "0011100";
			HEX2 <= "1100010";
			HEX3 <= "0011100";
		WHEN D  =>
			HEX0 <= "1100010";
			HEX1 <= "0011100";
			HEX2 <= "1111110";
			HEX3 <= "0011100";
		WHEN E  =>
			HEX0 <= "1111110";
			HEX1 <= "1111110";
			HEX2 <= "0011100";
			HEX3 <= "0011100";
		WHEN F  =>
			HEX0 <= "0011100";
			HEX1 <= "0011100";
			HEX2 <= "1100010";
			HEX3 <= "1100010";
		WHEN G  =>
			HEX0 <= "0011100";
			HEX1 <= "0011100";
			HEX2 <= "1111110";
			HEX3 <= "1111110";
			
	END CASE;
	END PROCESS;
	
END Structural;