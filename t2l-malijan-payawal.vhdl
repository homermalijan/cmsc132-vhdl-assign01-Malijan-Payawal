--Homer Malijan
--Gabrielle Pauline Payawal
--T-2L
--VHDL programming assignment

-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;

-- Entity Definition
entity buzzer is
	-- 1 = out
	-- 0 = in
	port (
		valid: out std_logic;
		boggis0: in std_logic;
		boggis1: in std_logic;
		bunce0: in std_logic;
		bunce1: in std_logic;
		bean0: in std_logic;
		bean1: in std_logic		
	);			
end entity buzzer;

architecture buzzer of buzzer is
begin
	--valid when atleast one from any of in and out is on
	valid <= (boggis0 or bunce0 or bean0) and (boggis1 or bunce1 or bean1);
	--valid <= (boggis0 or boggis1) or (bunce0 or bunce1) or (bean0 or bean1);
end architecture buzzer;

