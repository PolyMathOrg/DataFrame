baselines
baseline: spec
	<baseline>
	
	spec for: #common do: [
		spec
			package: 'DataFrame';
			package: 'DataFrame-Tests' with: [ 
				spec requires: 'DataFrame' ]].
