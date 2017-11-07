--- Julio Alves Meesquita da Silva -- 156061 --
--- Gabriel Bonani Machado 		  -- 155416 --

LIBRARY ieee; 
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY proc IS
	PORT ( DIN : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Resetn, Clock, Run : IN STD_LOGIC;
		Done : BUFFER STD_LOGIC;
		BusWires : BUFFER STD_LOGIC_VECTOR(15 DOWNTO 0);
		ADDR, DOUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		W, addrstall : OUT STD_LOGIC);
END proc;

ARCHITECTURE Behavior OF proc IS
	---   declare components
	Component Mux IS
		PORT ( 
			R0,R1,R2,R3,R4,R5,R6,R7,G,Din : IN STD_LOGIC_VECTOR(15 downto 0);
			Rcontrol : IN STD_LOGIC_VECTOR(7 downto 0);
			Dcontrol, Gcontrol : IN STD_LOGIC;
			Q : OUT STD_LOGIC_VECTOR(15 downto 0));
	END Component;
	
	Component Soma8 IS
		PORT ( 
			A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			SUB : IN STD_LOGIC;
			Q: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			OVER: OUT STD_LOGIC);
	END Component;
	
	
	Component dec3to8 IS
		PORT ( 
			W : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			En : IN STD_LOGIC;
			Y : OUT STD_LOGIC_VECTOR(0 TO 7));
	END Component;
	
	Component regn IS
		GENERIC (
			n : INTEGER := 16);
		PORT ( 
			R : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Rin, Clock : IN STD_LOGIC;
			Q : BUFFER STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END Component;
	
	component counter is
		generic (
			n : natural := 16
		);
		port (
			clock ,reset_n, incr_pc : in std_logic;
			PCin : in std_logic;
			Input : in STD_LOGIC_VECTOR(n-1 downto 0);
			count : out STD_LOGIC_VECTOR(n-1 downto 0)
		); 
	end component;
	
	COMPONENT FLIPFLOP IS
		PORT ( 
			CLK,D, RESET : IN STD_LOGIC;
			Q : OUT STD_LOGIC);
	END COMPONENT;
	
	---   declare signals
	TYPE State_type IS (TF, TF2, T0, T1, T2, T3);
	SIGNAL Tstep_Q, Tstep_D: State_type;
	
	SIGNAL RYout, RXin, DINout,RXout,Ain,Gin,Gout,AddSub,IRin,Over,High,incr_pc,zero,PCout: std_LOGIC;
	
	SIGNAL R0,R1,R2,R3,R4,R5,R6,R7,A,G,GBus : STD_LOGIC_VECTOR(15 downto 0);
	
	SIGNAL IR : STD_LOGIC_VECTOR(0  TO 8);
	
	SIGNAL I : STD_LOGIC_VECTOR(0 TO 2);
	
	SIGNAL Xreg, Yreg, Rin , Rout: STD_LOGIC_VECTOR(0 TO 7);
	
	BEGIN
	
	High <= '1';
	I <= IR(0 TO 2);
	
	decX: dec3to8 PORT MAP (IR(3 TO 5), High, Xreg);
	decY: dec3to8 PORT MAP (IR(6 TO 8), High, Yreg);
	
	statetable: PROCESS (Tstep_Q, Run, Done)
	BEGIN
	
	CASE Tstep_Q IS
		WHEN TF => IF(Run = '0') THEN Tstep_D <= TF;
			ELSE Tstep_D <= TF2;
			END IF; --- data is loaded into IR in this time step other states
		WHEN TF2 => IF(Run = '0') THEN Tstep_D <= TF2;
			ELSE Tstep_D <= T0;
			END IF; --- data is loaded into IR in this time step other states
		WHEN T0 => IF(Run = '0') THEN Tstep_D <= T0;
			ELSE Tstep_D <= T1;
			END IF; --- data is loaded into IR in this time step other states
		WHEN T1 => IF(Run = '0') THEN Tstep_D <= T1;
			ELSIF (Done = '1') THEN Tstep_D <= TF;
			ELSE Tstep_D <= T2;
			END IF;
		WHEN T2 => IF(Run = '0') THEN Tstep_D <= T2;
			ELSIF (Done = '1') THEN Tstep_D <= TF;
			ELSE Tstep_D <= T3;
			END IF;
		WHEN T3 => IF(Run = '0') THEN Tstep_D <= T3;
			ELSE Tstep_D <= TF;
			END IF;
	END CASE;
	END PROCESS;
	
	controlsignals: PROCESS (Tstep_Q, I, Xreg, Yreg, Done, G)
	BEGIN
	
	IF(G = "0000000000000000") THEN 
		zero <= '1';
	ELSE 
		zero <= '0';
	END IF;
	
	--- specify initial values
	CASE Tstep_Q IS
	
		WHEN TF => --- store DIN in IR as long as Tstep_Q = 0
			IRin <= '0';
			RYout <= '0';
			RXin <= '0';
			DINout <='0';
			RXout<='0';
			Ain<= '0';
			Gin <= '0';
			Gout <= '0';
			AddSub <= '0';
			Done <= '0';
			W <= '0';
			PCout <= '1';
			incr_pc <= '0';
			addrstall <= '0';
			
		WHEN TF2 =>
			RYout <= '0';
			RXin <= '0';
			DINout <='0';
			RXout<='0';
			Ain<= '0';
			Gin <= '0';
			Gout <= '0';
			AddSub <= '0';
			Done <= '0';
			IRin <= '0';
			W <= '0';
			PCout <= '0';
			incr_pc <= '0';
			addrstall <= '1';
			
		WHEN T0 => --- store DIN in IR as long as Tstep_Q = 0
			IRin <= '1';
			RYout <= '0';
			RXin <= '0';
			DINout <='0';
			RXout<='0';
			Ain<= '0';
			Gin <= '0';
			Gout <= '0';
			AddSub <= '0';
			Done <= '0';
			W <= '0';
			PCout <= '0';
			incr_pc <= '1';
			addrstall <= '0';
			
		WHEN T1 => --- define signals in time step T1
			CASE I IS
				WHEN "000" =>
					RYout <= '1';
					RXin <= '1';
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '1';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';
					
				when "001" =>
					RYout <= '0';
					RXin <= '0';
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '0';
					IRin <= '0';
					W <= '0';
					PCout <= '1';
					incr_pc <= '0';
					addrstall <= '0';

				when "010" =>
					RYout <= '0';
					RXin <= '0';
					DINout <='0';
					RXout<='1';
					Ain<= '1';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '0';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';
					
				when "011"=>
					RYout <= '0';
					RXin <= '0';
					DINout <='0';
					RXout<='1';
					Ain<= '1';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '0';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';
					
				when "100"=>
					RYout <= '1';
					RXin <= '0';
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '0';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';
					
				when "101"=>
					RYout <= '1';
					RXin <= '0';
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '0';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';
				
				when "110" =>
					RYout <= '1';
					RXin <= '1' and not zero;
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '1';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';
					
				when others =>
					RYout <= '0';
					RXin <= '0';
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '1';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';

			END CASE;
			
		WHEN T2 => --- define signals in time step T2
			CASE I IS
				when "001" =>
					RYout <= '0';
					RXin <= '0';
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '0';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '1';
					addrstall <= '1';

					
				when "010" =>
					RYout <= '1';
					RXin <= '0';
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '1';
					Gout <= '0';
					AddSub <= '0';
					Done <= '0';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';

				when "011"=>
					RYout <= '1';
					RXin <= '0';
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '1';
					Gout <= '0';
					AddSub <= '1';
					Done <= '0';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';
					
				when "100"=>
					RYout <= '0';
					RXin <= '0';
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '0';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '1';
					
				when "101"=>
					RYout <= '0';
					RXin <= '0';
					DINout <='0';
					RXout<='1';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '0';
					IRin <= '0';
					W <= '1';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '1';
					
				when others =>
					RYout <= '0';
					RXin <= '0';
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '1';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';

				
			END CASE;
			
		WHEN T3 => --- define signals in time step T3
			CASE I IS
				when "001" =>
					RYout <= '0';
					RXin <= '1';
					DINout <='1';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '1';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';
			
				when "010" =>
					RYout <= '0';
					RXin <= '1';
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '1';
					AddSub <= '0';
					Done <= '1';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';

				when "011"=>
					RYout <= '0';
					RXin <= '1';
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '1';
					AddSub <= '0';
					Done <= '1';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';
					
				when "100"=>
					RYout <= '0';
					RXin <= '1';
					DINout <='1';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '1';
					IRin <= '0';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';
					
				when "101"=>
					RYout <= '0';
					RXin <= '0';
					DINout <='0';
					RXout<='1';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '1';
					IRin <= '0';
					W <= '1';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '1';
					
					
				when others =>
					RYout <= '0';
					RXin <= '0';
					DINout <='0';
					RXout<='0';
					Ain<= '0';
					Gin <= '0';
					Gout <= '0';
					AddSub <= '0';
					Done <= '1';
					W <= '0';
					PCout <= '0';
					incr_pc <= '0';
					addrstall <= '0';
				END CASE;
		
	END CASE;
	
	END PROCESS;
	
	registercontrol: PROCESS(RXout,RYout,RXin,PCout)
	BEGIN
	
	IF(RXout = '1') then
		Rout <= Xreg;
	ELSIF(RYout = '1') then
		Rout <= Yreg;
	ELSIF(PCout = '1') then 
		Rout <= "00000001";
	ELSE
		Rout <= "00000000";
	END IF;
	
	IF(RXin = '1') then
		Rin <= Xreg;
	ELSe
		Rin <= "00000000";
	END IF;
	
	
	END PROCESS;
	
	fsmflipflops: PROCESS (Clock, Resetn, Tstep_D)
	BEGIN
	if (Resetn = '1') then
		Tstep_Q <= TF;
	elsif (rising_edge(Clock)) then
		Tstep_Q <= Tstep_D;
	end if;
	END PROCESS;
	
	reg_0: regn PORT MAP (BusWires, Rin(0), Clock, R0);
	reg_1: regn PORT MAP (BusWires, Rin(1), Clock, R1);
	reg_2: regn PORT MAP (BusWires, Rin(2), Clock, R2);
	reg_3: regn PORT MAP (BusWires, Rin(3), Clock, R3);
	reg_4: regn PORT MAP (BusWires, Rin(4), Clock, R4);
	reg_5: regn PORT MAP (BusWires, Rin(5), Clock, R5);
	reg_6: regn PORT MAP (BusWires, Rin(6), Clock, R6);
	
	reg_pc: counter PORT MAP (Clock, Resetn, incr_pc, Rin(7), BusWires, R7);
	
	reg_A: regn PORT MAP (BusWires, Ain, Clock, A);
	reg_G: regn PORT MAP (GBus, Gin, Clock, G);
	
	ADDR <= BusWires;
	DOUT <= BusWires;
	
	reg_I: regn 
		generic map (9)
		PORT MAP (DIN(15 downto 7), IRin, Clock, IR);
	
	--- instantiate other registers and the adder/subtracter unit
	Adder: Soma8 PORT MAP (A, BusWires, AddSub, GBus, Over);
	
	Mutiplex: Mux PORT MAP(R0,R1,R2,R3,R4,R5,R6,R7,G,Din,Rout,DINout,Gout,BusWires);
	
	--- define the bus
	
END Behavior;