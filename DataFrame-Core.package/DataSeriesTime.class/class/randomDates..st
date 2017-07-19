instance creation
randomDates: aNumber

	| lo hi rand |
	lo := 0.
	hi := (DateAndTime now) asSeconds.
	rand := Random new.
	
	^ self newFrom: (
		(1 to: aNumber) collect: [ :each |
			| seconds |
			
			"A random integer between lo and hi"
			seconds := (rand nextInt: (hi - lo)) + lo.
			(DateAndTime fromSeconds: seconds) asString ]).