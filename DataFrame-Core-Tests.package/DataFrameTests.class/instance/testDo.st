tests
testDo

	| actual expected |

	expected := LinkedList
		with: #('Barcelona' 1.609 true) asDataSeries
		with: #('Dubai' 2.789 true) asDataSeries
		with: #('London' 8.788 false) asDataSeries.
		
	expected doWithIndex: [ :each :i |
		each keys: #(City Population BeenThere).
		each name: (#(A B C) at: i) ].
		
	actual := LinkedList new.
	
	df do: [ :each |
		actual add: each ].
	
	self assert: actual equals: expected.