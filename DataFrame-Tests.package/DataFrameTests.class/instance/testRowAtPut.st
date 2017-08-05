tests
testRowAtPut

	| actual expected |

	expected := DataFrame fromRows: #(
		('Barcelona' 1.609 true)
   		('X' 'Y' 'Z')
   		('London' 8.788 false)).
		
	expected rowNames: #(A B C).
	expected columnNames: #(City Population SomeBool).
	
	actual := df.
	actual rowAt: 2 put: #('X' 'Y' 'Z').
	
	self assert: actual equals: expected.