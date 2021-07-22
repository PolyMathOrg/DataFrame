Extension { #name : #String }

{ #category : #'*DataFrame' }
String >> using: aBlock [
	"Answer a block which takes two arguments: a data frame and a column name. This block groups a column of data frame which has name equal to myself by the values of another column, aggregates them using aBlock, and returns a new data series"
	^ [ :dataFrame :groupColumnName |
		dataFrame
			group: self
			by: groupColumnName
			aggregateUsing: aBlock ]
]

{ #category : #'*DataFrame' }
String >> using: aBlock as: aNewName [
	"Answer a block which takes two arguments: a data frame and a column name. This block groups a column of data frame which has name equal to myself by the values of another column, aggregates them using aBlock, and returns a new data series with aNewName"
	^ [ :dataFrame :groupColumnName |
		dataFrame
			group: self
			by: groupColumnName
			aggregateUsing: aBlock
			as: aNewName ]
]
