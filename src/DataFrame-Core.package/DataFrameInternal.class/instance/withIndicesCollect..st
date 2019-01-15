enumerating
withIndicesCollect: aBlock

	^ self class fromMatrix:
		(contents withIndicesCollect: aBlock).