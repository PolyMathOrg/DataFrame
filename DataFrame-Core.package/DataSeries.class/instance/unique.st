as yet unclassified
unique

	| unique |
	unique := LinkedList new.

	self collect: [ :each |
	(unique includes: each)
		ifFalse: [ unique add: each ] ].
	
	^ unique asDataSeries.