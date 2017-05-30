accessing
columnAt: aNumber

	^ (self collect: [ :row |
			row at: aNumber ]) asDataSeries.