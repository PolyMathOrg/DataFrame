as yet unclassified
eachColumnAlign: aDataFrame
"Returns an array of characters specifying how each column should be aligned based on its type. Possible values are #LEFT, #RIGHT, and #CENTER"

	^ aDataFrame columnTypes collect: [ :type |
		((type inheritsFrom: String) or:
		(type == String))
			ifTrue: [ #LEFT ]
			ifFalse: [ #RIGHT ] ].