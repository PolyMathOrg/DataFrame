initialization
fillWithValuesOf: anArray
"Fills a newly created series with values of an array. This method is called from the fromArray: class method. It should only be called after initialize: as it is assumed that the memory was already allocated and the size of the self is equal to the size of array.
This method is private and should not be used in custom applications"

	anArray doWithIndex: [ :each :i |
		contents at: i put: each ].