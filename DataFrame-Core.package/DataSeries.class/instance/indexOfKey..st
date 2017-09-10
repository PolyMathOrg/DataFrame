private
indexOfKey: aKey

	^ self indexOfKey: aKey ifAbsent: [
		NotFoundError signal:
			'Key ',
			aKey asString,
			' was not found in ',
			self class asString ].