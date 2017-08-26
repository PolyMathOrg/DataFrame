accessing
columnsFrom: begin to: end

	| array |
	
	array := begin < end
		ifTrue: [ (begin to: end) asArray ]
		ifFalse: [ (end to: begin) asArray reverse ].
	
	^ self columnsAt: array.