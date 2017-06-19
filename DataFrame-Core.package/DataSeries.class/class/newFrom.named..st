instance creation
newFrom: aDictOrCollection named: aName

	| series |
	series := self newFrom: aDictOrCollection.
	series name: aName.
	^ series