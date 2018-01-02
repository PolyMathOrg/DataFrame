initialization
setDefaultKeys
"Sets the keys of a series to their default values - to an array of numbers from 1 to self size. This method can be reimplemented by a subclass to provide different default keys"

	keys := (1 to: self size) asArray.