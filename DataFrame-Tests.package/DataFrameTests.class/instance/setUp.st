initialization
setUp

	df := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('Dubai' 2.789 true)
   		('London' 8.788 false)).
		
	df rowNames: #(A B C).
	df columnNames: #(City Population BeenThere).