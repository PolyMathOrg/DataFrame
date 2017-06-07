baselines
baseline: spec
	<baseline>
	
	spec for: #common do: [
		spec
			project: 'Roassal2' with: [
				spec
					className: 'ConfigurationOfRoassal2';
					version: #stable;
					file:  'ConfigurationOfRoassal2';
					repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal2/main/' ];
				
			package: 'DataFrame';
			package: 'DataFrame-Plots' with: [ 
				spec requires: 'DataFrame' ];
			package: 'DataFrame-Tests' with: [ 
				spec requires: 'DataFrame' ]].
