tests
testColumnPut

	| actual expected |

	expected := DataFrame fromRows: #(
		('X' 1.609 0)
   		('Y' 2.789 1)
   		('Z' 8.788 0)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population SomeBool).
	
	actual := df.
	actual column: #City put: #(X Y Z).
	actual column: #SomeBool put: #(0 1 0).
	
	self assert: actual equals: expected.