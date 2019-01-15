sorting
mergeFirst: first middle: middle last: last into: dst by: aBlock
	"Private. Merge the sorted ranges [first..middle] and [middle+1..last] 
	of the receiver into the range [first..last] of dst."

	| i1 i2 key1 key2 val1 val2 out |
	i1 := first.
	i2 := middle + 1.
	key1 := self keys at: i1.
	key2 := self keys at: i2.
	val1 := self at: i1.
	val2 := self at: i2.
	out := first - 1.  "will be pre-incremented"

	"select 'lower' half of the elements based on comparator"
	[ (i1 <= middle) and: [i2 <= last] ]
		whileTrue: [
			out := out + 1.
			
			(aBlock value: val1 value: val2)
				ifTrue: [
					dst at: out put: val1.
					dst keys at: out put: key1.
					i1 := i1 + 1.
					val1 := self at: i1.
					key1 := self keys at: i1 ]
				
				ifFalse: [
					dst at: out put: val2.
					dst keys at: out put: key2.
					i2 := i2 + 1.
					i2 <= last
						ifTrue: [
							val2 := self at: i2.
							key2 := self keys at: i2 ] ] ].

	"copy the remaining elements"
	i1 <= middle
		ifTrue: [dst replaceFrom: out + 1 to: last with: self startingAt: i1]
		ifFalse: [dst replaceFrom: out + 1 to: last with: self startingAt: i2]