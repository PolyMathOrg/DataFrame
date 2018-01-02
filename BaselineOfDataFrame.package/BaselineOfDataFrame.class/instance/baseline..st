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
					group: 'Core' with: #('DataFrame-Core');
					group: 'Tools' with: #('DataFrame-Tools');
					group: 'CoreTests' with: #('DataFrame-Core-Tests');
					group: 'Tests' with: #('CoreTests' 'DataFrame-Tools-Tests');
					group: 'all' with: #('Tests');
					group: 'default' with: #('all') ].