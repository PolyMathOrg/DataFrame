as yet unclassified
eachColumnMaxLength: aDataFrame
"For every column converts all values to strind and determines the length of the longest string"

	| maxLenArray findMaxLen |
	
	maxLenArray := Array new: (aDataFrame numberOfColumns + 1).
	
	findMaxLen := [ :initMaxLen :column |
		| len maxLen |
		maxLen := initMaxLen.
		
		(1 to: column size) do: [ :i |
			len := (column at: i) asString size.
			
			len > maxLen
				ifTrue: [ maxLen := len ] ].
		maxLen ].
	
	maxLenArray at: 1 put:
		(findMaxLen value: 0 value: aDataFrame rowNames).
	
	1 to: aDataFrame numberOfColumns do: [ :i |
		| column |
		column := aDataFrame columnAt: i.
		
		maxLenArray at: (i + 1) put:
			(findMaxLen
				value: column name asString size
				value: column) ].
			
	^ maxLenArray