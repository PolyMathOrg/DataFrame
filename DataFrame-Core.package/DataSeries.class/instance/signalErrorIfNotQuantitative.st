error signalling
signalErrorIfNotQuantitative

	self isQuantitative not
		ifTrue: [
			Error signal:
				'Variable ', self name asString, ' is not quantitative. ',
				'Arithmetic and statistical operations can only be applied ',
				'to quantitative variables' ].