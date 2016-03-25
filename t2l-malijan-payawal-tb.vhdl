--Homer Malijan
--Gabrielle Pauline Payawal
--T-2L
--VHDL programming assignment testbench

library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity buzzer_tb is
	constant DELAY: time := 10 ns;		-- delay value in testing
end entity buzzer_tb;

architecture tb of buzzer_tb is
	--signals for gtkwave
	signal valid, boggis0, boggis1, bunce0, bunce1, bean0, bean1: std_logic;
		
	--declare component
	component buzzer is
		port (
			valid: out std_logic;
			boggis0: in std_logic;
			boggis1: in std_logic;
			bunce0: in std_logic;
			bunce1: in std_logic;
			bean0: in std_logic;
			bean1: in std_logic		
		);	
	end component buzzer;
	
begin	
	--connect 
	UUT: component buzzer port map(valid, boggis0, boggis1, bunce0, bunce1, bean0, bean1);
	
	main: process is
		variable temp: unsigned(5 downto 0);	--used in calculations
		variable expected_valid: std_logic;
		variable error_count: integer := 0;		--number if simulation errors
		
		begin
			report "Start simulation.";
			
			for count in 0 to 63 loop
				temp := TO_UNSIGNED(count,6);
				bean1 <= std_logic(temp(5));						--bean out
				bean0 <= std_logic(temp(4));						--bean in
				bunce1 <= std_logic(temp(3)); 						--bunce out
				bunce0 <= std_logic(temp(2)); 						--bunce in
				boggis1 <= std_logic(temp(1));						--boggis out
				boggis0 <= std_logic(temp(0));						--boggis in
				
				--compute expected values
				if(count=0) then									--unknown row 0
					expected_valid := 'U';
				elsif(boggis0='1' and (boggis1='1' or bunce1='1' or bean1='1' )) then 
					expected_valid := '1';							--boggis in and any out 
				elsif(boggis1='1' and (bunce0='1' or bean0='1')) then
					expected_valid := '1';							--boggis out and bunce or bean in
				elsif(bunce0='1' and (bunce1='1' or bean1='1')) then
					expected_valid := '1';							--bunce in and bunce or bean out
				elsif(bunce1='1' and bean0='1') then
					expected_valid := '1';							--bunce out and bean in
				elsif(bean0='1' and bean1='1') then
					expected_valid := '1';							--last case bean in and out for valid
				else
					expected_valid := '0';							--else off alarm
				end if;
				
				-- check if output of circuit is same with expected value
				assert(expected_valid = valid)
					report "ERROR: Expected valid " &
						std_logic'image(expected_valid) & " and actual " &
						std_logic'image(valid) & " at count " &
						integer'image(count) &
						std_logic'image(boggis0) &
						std_logic'image(bunce0) &
						std_logic'image(bean0) &
						std_logic'image(boggis1) &
						std_logic'image(bunce1) &
						std_logic'image(bean1);
						
				-- increment number of errors		
				if(expected_valid/= valid) then
					error_count := error_count + 1;
				end if;

				wait for DELAY;
			end loop;		
			
			-- report errors
			assert(error_count=0)
				report "ERROR: There were " &
					integer'image(error_count) & " errors!";
					
			-- if there are no errors		
			if(error_count = 0) then
				 report "Simulation completed with NO errors.";
			end if;
			
			wait; -- terminate the simulation
		end process;
end architecture tb;
