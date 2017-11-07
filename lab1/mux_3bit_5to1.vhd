LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_3bit_5to1
 IS
	PORT ( S, U, V, W, X, Y : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	M : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END mux_3bit_5to1;

ARCHITECTURE Behavior OF mux_3bit_5to1
 IS
	signal A, B, C : STD_LOGIC_VECTOR(2 DOWNTO 0);
	BEGIN
	
	A(2) <= (NOT (S(0)) AND U(2)) OR (S(0) AND V(2));
	A(1) <= (NOT (S(0)) AND U(1)) OR (S(0) AND V(1));
	A(0) <= (NOT (S(0)) AND U(0)) OR (S(0) AND V(0));

	B(2) <= (NOT (S(0)) AND W(2)) OR (S(0) AND X(2));
	B(1) <= (NOT (S(0)) AND W(1)) OR (S(0) AND X(1));
	B(0) <= (NOT (S(0)) AND W(0)) OR (S(0) AND X(0));
	
	C(2) <= (NOT (S(1)) AND A(2)) OR (S(1) AND B(2));
	C(1) <= (NOT (S(1)) AND A(1)) OR (S(1) AND B(1));
	C(0) <= (NOT (S(1)) AND A(0)) OR (S(1) AND B(0));
	
	M(2) <= (NOT (S(2)) AND C(2)) OR (S(2) AND Y(2));
	M(1) <= (NOT (S(2)) AND C(1)) OR (S(2) AND Y(1));
	M(0) <= (NOT (S(2)) AND C(0)) OR (S(2) AND Y(0));
	
END Behavior;
