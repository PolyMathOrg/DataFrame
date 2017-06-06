instance creation
from: start to: end

	^ ((start to: end) collect: [ :i |
		self at: i ]) asDataSeries.