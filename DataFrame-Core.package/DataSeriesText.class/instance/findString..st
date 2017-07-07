converting
findString: aString
	
	^ self collect: [ :each | each findString: aString ]