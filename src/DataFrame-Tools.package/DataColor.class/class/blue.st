examples
blue

	^ self fromHexString: (
		(self defaultColors detect: [ :assoc |
			assoc key = #blue ]) value).