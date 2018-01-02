accessing
atKey: aKey

	^ self atKey: aKey ifAbsent: [
		NotFoundError signal:
			'Key ',
			aKey asString,
			' was not found in ',
			self class asString ].