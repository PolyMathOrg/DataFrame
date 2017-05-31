baselines
baseline01: spec
 	<version: '0.1-baseline'>

 	spec for: #common do: [  
		spec blessing: #baseline.
		spec repository: 'github://PolyMathOrg/DataFrame'.
		
		"spec project: 'PolyMath' with: [ 
			spec 
				className: 'ConfigurationOfPolyMath';
				version: #stable;
				repository: 'http://www.smalltalkhub.com/mc/PolyMath/PolyMath/main' ].
		
		spec project: 'Roassal2' with: [
  			spec
    			className: 'ConfigurationOfRoassal2';
				version: #stable;
    			repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ].
		
		spec baseline: 'IdxReader' with: [
  			spec
    			repository: 'github://guillep/idx-reader' ].
    
		spec 
  			package: 'MLData' with: [ spec requires: #('PolyMath' 'IdxReader') ];
  			package: 'MLNeuralNetwork' with: [ spec requires: 'PolyMath' ];
			package: 'MLNeuralNetwork-Tests' with: [ spec requires: #('MLNeuralNetwork' 'PolyMath') ];
			package: 'MLVisualizer' with: [ spec requires: 'Roassal2' ];
			package: 'NeuralNetwork' with: [ spec requires: 'PolyMath' ];
			package: 'NeuralNetwork-Tests' with: [ spec requires: 'NeuralNetwork' ]."
	]