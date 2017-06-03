examples
red

	^ self fromHexString: (
		(self defaultColors detect: [ :assoc |
			assoc key = #red ]) value).