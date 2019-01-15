examples
purple

	^ self fromHexString: (
		(self defaultColors detect: [ :assoc |
			assoc key = #purple ]) value).