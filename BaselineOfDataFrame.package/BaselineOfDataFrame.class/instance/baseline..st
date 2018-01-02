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
				
				"Packages"
				spec 
					package: 'DataFrame-Core';
					package: 'DataFrame-Core-Tests' with: [ spec requires: #('DataFrame-Core') ];
					package: 'DataFrame-Tools' with: [ spec requires: #('DataFrame-Core' 'Roassal2') ];
					package: 'DataFrame-Tools-Tests' with: [ spec requires: #('DataFrame-Tools') ].
			
				"Groups"
				spec
					group: 'core' with: #('DataFrame-Core');
					group: 'tools' with: #('DataFrame-Tools');
					group: 'tests' with: #('DataFrame-Core-Tests' 'DataFrame-Tools-Tests');
					group: 'all' with: #('tests');
					group: 'default' with: #('all') ].