accessing
columnNames: anArray

	columnNames := anArray asDataSeries.

	self do: [ :rowSeries |
		rowSeries keys: anArray ].