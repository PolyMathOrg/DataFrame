*DataFrame-Tools
barplot

	| n composer palette b |

	n := self numericColumnNames size.
	composer := RTComposer new.
	
	palette := DataColor palette: n.
	
	(self numericColumnNames) doWithIndex: [ :columnName :i |
		b := (self column: columnName) barplotWithColor: (palette at: i).
		b extent: 500 @ (300 / n).
		b view: composer view.
		b build.
		composer group: 'b', i asString ].
	
	2 to: n do: [ :i |
		composer
			move: ('b', i asString)
			below: ('b', (i - 1) asString) ].
		
	^ composer view