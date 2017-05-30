*DataFrame
asDataSeries

	| aSeries index |
	aSeries := DataSeries new: self size.
	index := 0.
	self do: [:each | aSeries at: (index := index + 1) put: each].
	^ aSeries

