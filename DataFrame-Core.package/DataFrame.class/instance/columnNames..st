accessing
columnNames: anArray

	columnNames := anArray.

	self do: [ :rowSeries |
		rowSeries keys: anArray ].