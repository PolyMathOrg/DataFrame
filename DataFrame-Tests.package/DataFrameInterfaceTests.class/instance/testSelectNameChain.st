tests
testSelectNameChain

	self shouldnt: [
		DataFrame new
   			select: [ :x | x = 'House Stark']
    		with: #('Allegiances');
    		columns: #('Name' 'Death Chapter').
	] raise: MessageNotUnderstood.