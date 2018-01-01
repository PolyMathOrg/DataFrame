accessing
keyAtValue: value

	^ self keyAtValue: value ifAbsent: [ ValueNotFound signalFor: value ]