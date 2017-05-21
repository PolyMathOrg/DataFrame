tests
testColumnNames

	self shouldnt: [ 
		DataFrame new columnNames.
		DataFrame new columnNames: #('Name' 'Gender').
	] raise: MessageNotUnderstood.