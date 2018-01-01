examples
lightBlue

	^ self fromHexString: (
		(self defaultColors detect: [ :assoc |
			assoc key = #lightBlue ]) value).