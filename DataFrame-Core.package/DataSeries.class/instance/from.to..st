instance creation
from: start to: end

	| series |
	series := ((start to: end) collect: [ :i |
		self at: i]) asDataSeries.
	
	series name: self name.
	series keys: (self keys copyFrom: start to: end).
	^ series.