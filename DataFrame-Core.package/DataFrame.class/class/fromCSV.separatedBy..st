instance creation
fromCSV: pathToFile separatedBy: separator

	| data df |
	
	data := (((FileStream readOnlyFileNamed: pathToFile)
		contentsOfEntireFile " read and close "
		findTokens: String crlf) " split into lines "
		reject: [:e | e isEmpty]) " lose empty lines "
		collect: [:e | e findTokens: separator]. " split into fields "

	df := self fromRows: (data copyFrom: 2 to: data size).	
	df columnNames: (data at: 1) asArray.
	
	"Deduce types"
	"1 to: (df columnNames size) do: [ :i | | col convertedCol |
		col := df columnAt: i.
		convertedCol := (df columnAt: i) deduceType."
		
		"If a type was deduced"
		"( col = convertedCol ) ifFalse: [ 
			1 to: df size do: [ :j |
				df at: j at: i put: (convertedCol at: j) ] ] ]."
		
	^ df