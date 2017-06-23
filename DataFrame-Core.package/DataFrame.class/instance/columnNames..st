accessing
columnNames: anArray

	"Just in case :)"
	columnNames := anArray asArray.

	self do: [ :rowSeries |
		rowSeries keys: anArray ].