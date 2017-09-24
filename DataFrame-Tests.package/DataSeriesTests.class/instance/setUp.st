initialization
setUp

	series := (10 to: 100 by: 10) asDataSeries.
	keyArray := #(a b c d e f g h i j).
	
	series keys: keyArray.
	series name: 'ExampleSeries'.