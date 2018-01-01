examples
green

	^ self fromHexString: (
		(self defaultColors detect: [ :assoc |
			assoc key = #green ]) value).