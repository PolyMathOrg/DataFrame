tests
testCategoricalColumns

	self
		assert: df categoricalColumns
		equals: #(City BeenThere).