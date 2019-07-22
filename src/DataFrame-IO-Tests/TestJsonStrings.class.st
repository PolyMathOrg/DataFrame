Class {
	#name : #TestJsonStrings,
	#superclass : #Object,
	#category : #'DataFrame-IO-Tests'
}

{ #category : #running }
TestJsonStrings class >> columnJsonString [
	^ '{"col1":{"row1":1.0,"row2":null,"row3":null,"row4":1.0},
"col2":{"row1":2.0,"row2":2.0,"row3":null,"row4":null},
"col3":{"row1":null,"row2":3.0,"row3":null,"row4":2.0},
"col4":{"row1":null,"row2":null,"row3":5.0,"row4":null}}'
]

{ #category : #running }
TestJsonStrings class >> indexJsonString [
	^ '{"row1":{"col1":1.0,"col2":2.0,"col3":null,"col4":null},
"row2":{"col1":null,"col2":2.0,"col3":3.0,"col4":null},
"row3":{"col1":null,"col2":null,"col3":null,"col4":5.0},
"row4":{"col1":1.0,"col2":null,"col3":2.0,"col4":null}}'
]

{ #category : #running }
TestJsonStrings class >> nonNullJsonString1 [
	^ '[{"col1":1, "col2":2},
		 {"col3":3, "col2":2},
		 {"col4":5},
		 {"col1":1, "col3":2}]'
]

{ #category : #running }
TestJsonStrings class >> nonNullJsonString2 [
	^ '{
			"col1": {"row1":1, "row4":1},
			"col2": {"row1":2, "row2":2},
			"col3": {"row2":3, "row4":2},
			"col4": {"row3":5}
		}'
]

{ #category : #running }
TestJsonStrings class >> recordsJsonString [
	^ '[{"col1":1,"col2":2,"col3":null,"col4":null},
{"col1":null,"col2":2,"col3":3,"col4":null},
{"col1":null,"col2":null,"col3":null,"col4":5},
{"col1":1,"col2":null,"col3":2,"col4":null}]'
]

{ #category : #running }
TestJsonStrings class >> splitJsonString [
	^ '{"columns":["col1","col2","col3","col4"],
"index":["row1","row2","row3","row4"],
"data":[[1.0,2.0,null,null],[null,2.0,3.0,null],[null,null,null,5.0],[1.0,null,2.0,null]]}'
]

{ #category : #running }
TestJsonStrings class >> valuesJsonString [
	^ '[[1,2,null,null],[null,2,3,null],
[null,null,null,5],[1,null,2,null]]'
]
