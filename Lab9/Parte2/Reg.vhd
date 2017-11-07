LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Reg IS
	PORT ( 
		CLK, RESET,Sel : IN STD_LOGIC;
		A : IN STD_LOGIC_VECTOR(7 downto 0);
		Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END Reg;

ARCHITECTURE Structural OF reg IS
	
	BEGIN

	Process(A,RESET)
	variable S: std_LOGIC_VECTOR(7 downto 0);
	
	begin
	if(rising_edge(CLK)) then
		if(reset = '0') then
			S := "00000000";
		elsif (Sel = '1') then
			S := A;
		end if;
	end if;
	
	Q <= S;
	
	end Process;
	
END Structural;