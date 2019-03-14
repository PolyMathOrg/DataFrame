Extension { #name : #OrderedDictionary }

{ #category : #'*DataFrame-Pharo6' }
OrderedDictionary class >> newFromKeys: keys andValues: values [
	"Create a dictionary from the keys and values arguments which should have the same length."
	
	"(self newFromKeys: #(#x #y) andValues: #(3 6)) >>> (self new at: #x put: 3; at: #y put: 6 ;yourself)"
	
	| dict |
	dict := self new.
	keys with: values do: [ :k :v | dict at: k put: v ].
	^ dict
]
