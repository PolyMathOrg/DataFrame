private
leastCommonSuperclassOf: anArray
"Determines the closest element of class hierarchy which is the common ancestor of all the classes in the array"

	| commonSuperclass |
	commonSuperclass := anArray first.
	
	2 to: anArray size do: [ :i |
		commonSuperclass := self
			leastCommonSuperclassOf: (anArray at: i)
			and: commonSuperclass. ].
	
	^ commonSuperclass.