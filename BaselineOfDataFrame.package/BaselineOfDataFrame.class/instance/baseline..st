baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'GToolkitExamples' with: [ spec repository: 'github://feenkcom/gtoolkit-examples/src' ];
				project: 'Roassal2'
					with: [ spec
						className: 'ConfigurationOfRoassal2';
						version: #development;
						file: 'ConfigurationOfRoassal2';
						repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal2/main/' ];			
				package: 'DataFrame-Core';
				package: 'DataFrame-Plots' with: [ spec requires: #('DataFrame-Core' 'Roassal2') ];
				package: 'DataFrame-GTInspector' with: [ spec requires: 'DataFrame-Core' ];
				package: 'DataFrame-Tests' with: [ spec requires: 'DataFrame-Core' ];
				package: 'DataFrame-Examples' with: [ spec requires: #('DataFrame-Core' 'DataFrame-Plots' 'GToolkitExamples') ];
				package: 'DataFrame-DataSets' with: [ spec requires: 'DataFrame-Core' ];
				package: 'DataFrame-PrettyPrint';
				package: 'DataFrame-FTable'.]