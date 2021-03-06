library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity buttonLogika is
	port ( button : in std_logic; 
		  CLK_btn : in std_logic;
		  start : out std_logic;
		  reset : out std_logic);
end buttonLogika;

architecture Behavioral of buttonLogika is
signal Q : std_logic_vector(2 downto 0) :="000";--poczatkowa deklaracja Q

begin 

process(CLK_btn)
begin

if rising_edge(CLK_btn) then --przy wzrazstajacym zboczu sprawdza logike
	--1
	if (Q="000" and button='0') then
		Q<="001"; -- po wcisnięciu przycisku układ przechodzi do kolejnego stanu
		start<='0';
		reset<='0';
	end if;
	if (Q="000" and button='1') then
		Q<="000";
		start<='0';-- stan początkowy, stoper nie działa
		reset<='0';
	end if;
	
	--2
	if (Q="001" and button='0') then
		Q<="001";
		start<='1';-- układ zaczyna liczyć czas 
		reset<='0';
	end if;
	if (Q="001" and button='1') then
		Q<="010";-- układ liczy czas i przechodzi do kolejnego stanu
		start<='1';
		reset<='0';
	end if;
	
	--3
	if (Q="010" and button='0') then
		Q<="011";--wcisniecie kolejny raz przycisku powoduje przejscie do kolejnego stanu
		start<='1';
		reset<='0';
	end if;
	if (Q="010" and button='1') then
		Q<="010";
		start<='1';
		reset<='0';
	end if;
	
	--4
	if (Q="011" and button='0') then
		Q<="011";--układ zatrzymał czas
		start<='0';
		reset<='0';
	end if;
	if (Q="011" and button='1') then
		Q<="100";--puszczenie spowoduje przejscie do kolejnego stanu
		start<='0';
		reset<='0';
	end if;
	
	--5
	if (Q="100" and button='0') then
		Q<="101";--uklad nie liczy po wcisnieciu przejscie do kolejnego stanu
		start<='0';
		reset<='0';
	end if;
	if (Q="100" and button='1') then
		Q<="100";
		start<='0';
		reset<='0';
	end if;
	
	--6
	if (Q="101" and button='0') then
		Q<="101";--nastepuje zerowanie licznika
		start<='0';
		reset<='1';
	end if;
	if (Q="101" and button='1') then
		Q<="000";--po pouszczeniu przycisku przechodzimy do stanu poczatkowego
		start<='0';
		reset<='1';
	end if;
	
		
end if;

end process;

end Behavioral;