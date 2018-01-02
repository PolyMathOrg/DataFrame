enumerating
select: aBlock with: testedColumnNames
	
	| blockStr |
	blockStr := aBlock asString.
	
	"Remove parameters: '[ :x | x > 3 ]' to '[ x > 3 ]'"
	blockStr := (blockStr
		copyFrom: (blockStr findString: '|')
		to: blockStr size).
		
	testedColumnNames do: [ :eachColName |
		blockStr := blockStr
			copyReplaceAll: eachColName
			with: ('(row atKey: #', eachColName, ')') ].
		
	blockStr := '[ :row ', blockStr.
	^ self select: (Compiler evaluate: blockStr)