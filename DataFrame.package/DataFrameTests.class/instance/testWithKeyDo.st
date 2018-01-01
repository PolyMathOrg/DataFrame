tests
testWithKeyDo

	| actual expected |

	expected := Dictionary new.
	expected at: #A put: #('Barcelona' 1.609 true) asDataSeries.
	expected at: #B put: #('Dubai' 2.789 true) asDataSeries.
	expected at: #C put: #('London' 8.788 false) asDataSeries.
		
	expected keysAndValuesDo: [ :name :each |
		each keys: #(City Population BeenThere).
		each name: name ].
		
	actual := Dictionary new.
	
	df withKeyDo: [ :each :key |
		actual at: key put: each ].
	
	self assert: actual equals: expected.