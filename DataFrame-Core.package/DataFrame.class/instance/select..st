enumerating
select: aBlock 
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."

	| selectedRowNumbers df |
	
	selectedRowNumbers := LinkedList new.
	
	1 to: self numberOfRows do: [ :i | 
		(aBlock value: (self rowAt: i)) 
			ifTrue: [ selectedRowNumbers add: i ] ].
	
	df := self class new:
		(selectedRowNumbers size @ self numberOfColumns).
		
	df rowNames: (selectedRowNumbers collect: [ :i |
		self rowNames at: i ]) asArray.
	
	df columnNames: self columnNames.
		
	selectedRowNumbers doWithIndex: [ :rowNumber :i |
		df rowAt: i put: (self rowAt: rowNumber) ].
	
	^ df