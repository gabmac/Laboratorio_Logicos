LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY FF_T IS
PORT(
  ENABLE, Clk, Clr, T	 : IN std_logic;
  Q, Q_n : OUT std_logic
  );
END ENTITY;

ARCHITECTURE Comp OF FF_T IS

BEGIN
  PROCESS(Clk, Clr)
  VARIABLE Estado : std_logic := '0';

  BEGIN
    IF (Clr = '1') THEN
      Estado := '0';
    ELSIF ( rising_edge(Clk) AND ENABLE ='1' ) THEN
      IF (T = '0') THEN
        Estado := Estado;
      ELSIF (T = '1') THEN
        Estado := NOT Estado;
      END IF;
    END IF;

    Q <= Estado;
    Q_n <= NOT Estado;
	 
  END PROCESS;

END ARCHITECTURE;