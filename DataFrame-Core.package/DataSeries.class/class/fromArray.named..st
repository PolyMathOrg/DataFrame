instance creation
fromArray: anArray named: aName
	
	| series |
	series := self fromArray: anArray.
	series name: aName.
	^ series.
		
	