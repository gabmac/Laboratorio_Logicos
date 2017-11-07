--- Julio Alves Meesquita da Silva -- 156061 --
--- Gabriel Bonani Machado 		  -- 155416 --

--- 182 Componentes logicos

LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

ENTITY lab IS
PORT ( 
	SW : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	KEY :IN STD_LOGIC_VECTOR(0 DOWNTO 0);
	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: OUT STD_LOGIC_VECTOR(0 TO 6));
END ENTITY;

ARCHITECTURE Structural OF lab IS

	component Soma8 IS
	PORT ( 
		A, B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Q: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		OVER: OUT STD_LOGIC);
	END component;
	

	component seg IS
	 PORT (  SW : IN std_logic_vector (3 DOWNTO 0) ;
			 HEX0 : OUT std_logic_vector (0 TO 6)  ) ;
	END component;

	signal A, B: STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal P: std_LOGIC_VECTOR(16 downto 0);
	
	signal s1, s2, s3, s4, s5, s6, s7: STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal aux1, aux2, aux3, aux4, aux5, aux6, aux7: STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal over1, over2, over3, over4, over5, over6, over7: std_LOGIC;
	signal in1, in2, in3, in4, in5, in6, in7: std_LOGIC_VECTOR(7 downto 0);
	
	begin
	
	A <= SW(15 DOWNTO 8);
	B <= SW(7 DOWNTO 0);
	
	aux1(6 downto 0) <= A(7 downto 1) when B(0) = '1' else (others=>'0');
	aux1(7) <= '0';

	P(0) <= A(0) AND B(0);
	in1 <= A  when B(1) = '1' else (others=>'0');
	
	p1: Soma8 port map (aux1, in1, s1, over1);
	
	P(1) <= s1(0);
	
	aux2(6 downto 0) <= s1(7 downto 1);
	aux2(7) <= over1;
	
	in2 <= A when B(2) = '1' else (others=>'0');
	
	p2: Soma8 port map (aux2, in2, s2, over2);
	
	P(2) <= s2(0);
	
	aux3(6 downto 0) <= s2(7 downto 1);
	aux3(7) <= over2;
	
	in3<= A when B(3) = '1' else (others=>'0');
	
	p3: Soma8 port map (aux3, in3, s3, over3);
	P(3) <= s3(0);
	
	aux4(6 downto 0) <= s3(7 downto 1);
	aux4(7)<= over3;
	
	in4 <= A when B(4) = '1' else (others=>'0');
	
	p4: Soma8 port map (aux4, in4, s4, over4);
	P(4) <= s4(0);
	
	aux5(6 downto 0) <= s4(7 downto 1);
	aux5(7) <= over4;
	
	in5 <= A when B(5) = '1' else (others=>'0');
	
	p5: Soma8 port map (aux5, in5, S5, over5);
	P(5) <= s5(0);
	
	aux6(6 downto 0) <= s5(7 downto 1);
	aux6(7) <= over5;
	
	in6 <= A when B(6) = '1' else (others=>'0');
	
	p6: Soma8 port map (aux6, in6, S6, over6);
	P(6) <= s6(0);
	
	aux7(6 downto 0) <= s6(7 downto 1);
	aux7(7) <= over6;
	in7 <= A when B(7) = '1' else (others=>'0');
	
	p7: Soma8 port map (aux7, in7, s7, over7);
	
	P(14 downto 7) <= s7;
	p(15) <= over7;
	
	
	AD: seg port map (A(7 downto 4), HEX7);
	AU: seg port map (A(3 downto 0), HEX6);
	
	BD: seg port map (B(7 downto 4), HEX5);
	BU: seg port map (B(3 downto 0), HEX4);

	R4: seg port map (P(15 downto 12), HEX3);
	R3: seg port map (P(11 downto 8), HEX2);
	R2: seg port map (P(7 downto 4), HEX1);
	R1: seg port map (P(3 downto 0), HEX0);

END Structural;

	
