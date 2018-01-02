baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [
				spec project: 'Roassal2'
					with: [ spec
						className: 'ConfigurationOfRoassal2';
						version: #development;
						file: 'ConfigurationOfRoassal2';
						repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal2/main/' ].		
				spec 
				package: 'DataFrame' ].