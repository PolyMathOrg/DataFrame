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
	spec for: #common do: [	
		"External dependencies"
		spec
			baseline: 'NeoCSV'
			with: [ spec repository: 'github://svenvc/NeoCSV/repository' ].
				
		"Packages"
		spec 
			package: 'DataFrame';
			package: 'DataFrame-Tests' with: [ spec requires: #('DataFrame') ];
			package: 'DataFrame-IO' with: [ spec requires: #('DataFrame' 'NeoCSV') ];
			package: 'DataFrame-IO-Tests' with: [ spec requires: #('DataFrame-IO') ] ].
		
		spec
			for: #'pharo6.x'
			do: [ spec package: 'DataFrame-Pharo6' ]
]
