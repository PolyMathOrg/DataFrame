rendering
renderMatrix: aView
	| m elements x y box delta label |
	m := self metrics.
	self prepareScales.
	allDotElements := RTGroup new.
	m keys doWithIndex: [ :metric1 :j | 
		m keys doWithIndex: [ :metric2 :k |
			delta := ((k@j)* boxSize)+((k@j)*padding).
			box := self boxShape elementOn: k@j.
			box translateBy: delta.
			self boxes add: box.
			
			k = j ifTrue: [
				label := self labelShape elementOn: metric1.
				RTConstraint new
					fix: box; movable: label; inner;
					center; move.
				aView add: label  ]
			ifFalse: [
				elements := self shape elementsOn: self objects.
				elements do: [ :e | 
					x := (xScales at: metric1) scale: ((m at: metric1) rtValue: e model).
					y := (yScales at: metric2) scale: ((m at: metric2) rtValue: e model).
					e translateTo: (x @ y)+delta ].
				allDotElements addAll: elements.
				aView addAll: elements.
			].
			aView add: box.
		].
	].