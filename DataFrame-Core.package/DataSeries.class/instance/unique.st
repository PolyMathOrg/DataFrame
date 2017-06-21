as yet unclassified
unique

	| series |
	series := self asSet asDataSeries.
	series name: self name.
	^ series