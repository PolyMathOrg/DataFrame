tests
testSelect

	self shouldnt: [
		DataFrame new select: [ :x :y |
   			x = 'House Stark' and:
   			y = 1
		] with: #('Allegiances' 'Death Chapter').
	] raise: MessageNotUnderstood.