initialization
setUp

	df := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
		('Lviv' 0.724 true)
		('London' 8.788 false)
   		('Dubai' 2.789 true)).
		
	columnNames := #(City Population BeenThere).
		
	df rowNames: #(A B C D).
	df columnNames: columnNames.