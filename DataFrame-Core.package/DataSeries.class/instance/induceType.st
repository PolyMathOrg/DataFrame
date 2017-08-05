as yet unclassified
induceType
"Determines the least common superclass of all the values inside self and stores this class in type instance variable"

	| inductor |
	inductor := DataTypeInductor new.
	
	type := inductor typeOf: self.