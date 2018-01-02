instance creation
fromArray: anArray
	
	| series |
	series := self new: anArray size.
	series fillWithValuesOf: anArray.
	^ series.
		
	