"
This baseline is used to load the packages of the DataFrame project. The 'core' group can be used to load DataFrame as a lightweight collection with no dependencies.

Depends on:
- Roassal2

Load type: 
- linear

Installs:
- DataFrame-Core
- DataFrame-Core-Tests
- DataFrame-Tools
- DataFrame-Tools-Tests

Groups:
- Core (DataFrame-Core)
- CoreTests (DataFrame-Core, DataFrame-Core-Tests)
- Tools (DataFrame-Core, DataFrame-Tools)
- Tests (DataFrame-Core, DataFrame-Core-Tests, DataFrame-Tools, DataFrame-Tools-Tests)
- all (= Tests)
- default (= all)
"
Class {
	#name : #BaselineOfDataFrame,
	#superclass : #BaselineOf,
	#category : 'BaselineOfDataFrame'
}

{ #category : #baselines }
BaselineOfDataFrame >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
				spec
				project: 'Roassal2'
					with: [
					spec
						className: 'ConfigurationOfRoassal2';
						version: #development;
						file: 'ConfigurationOfRoassal2';
						repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal2/main/' ];
				project: 'Tabular' with: [
				spec
					className: 'ConfigurationOfTabular';
					versionString: #development;
					repository: 'http://ss3.gemtalksystems.com/ss/Tabular' ].				
				"Packages"
				spec 
					package: 'DataFrame-Core';
					package: 'DataFrame-Core-Tests' with: [ spec requires: #('DataFrame-Core') ];
					package: 'DataFrame-Tools' with: [ spec requires: #('DataFrame-Core' 'Roassal2' 'Tabular') ];
					package: 'DataFrame-Tools-Tests' with: [ spec requires: #('DataFrame-Tools') ].
			
				"Groups"
				spec
					group: 'Core' with: #('DataFrame-Core');
					group: 'Tools' with: #('DataFrame-Tools');
					group: 'CoreTests' with: #('DataFrame-Core-Tests');
					group: 'Tests' with: #('CoreTests' 'DataFrame-Tools-Tests');
					group: 'all' with: #('Tests');
					group: 'default' with: #('all') ].
]
