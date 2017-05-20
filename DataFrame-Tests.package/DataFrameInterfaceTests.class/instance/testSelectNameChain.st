tests
testSelectNameChain

	DataFrame new
   		select: [ :x | x = 'House Stark']
    	with: #('Allegiances');
    	columns: #('Name' 'Death Chapter').