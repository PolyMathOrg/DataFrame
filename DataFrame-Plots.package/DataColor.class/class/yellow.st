examples
yellow

	^ self fromHexString: (
		(self defaultColors detect: [ :assoc |
			assoc key = #yellow ]) value).