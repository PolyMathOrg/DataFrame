tests
testNameIndexColumn

	| df |
	df := DataFrame rows: #(('Name1')('Name2')).
	df columnNames: #('Name').
	
	self shouldnt: [ 
		df column: 'Name'.
	] raise: MessageNotUnderstood.