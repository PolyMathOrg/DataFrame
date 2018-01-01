removing
removeAt: aNumber

	contents removeAt: aNumber.
	keys := keys copyWithoutIndex: aNumber.
	self induceType.