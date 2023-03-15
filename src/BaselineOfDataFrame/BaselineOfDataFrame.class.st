Class {
	#name : #BaselineOfDataFrame,
	#superclass : #BaselineOf,
	#category : #BaselineOfDataFrame
}

{ #category : #baselines }
BaselineOfDataFrame >> baseline: spec [
	<baseline>
	spec for: #common do: [
		"External dependencies"
		spec
			baseline: 'NeoCSV'
			with: [ spec repository: 'github://svenvc/NeoCSV/repository' ].
		spec
			baseline: 'NeoJSON'
			with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
		spec
			baseline: 'AINormalization'
			with: [ spec repository: 'github://pharo-ai/normalization/src' ].

		"Packages"
		spec
			package: 'DataFrame' with: [ spec requires: #('AINormalization') ];
			package: 'DataFrame-Tests' with: [ spec requires: #('DataFrame') ];
			package: 'DataFrame-IO' with: [ spec requires: #('DataFrame' 'NeoCSV' 'NeoJSON') ];
			package: 'DataFrame-IO-Tests' with: [ spec requires: #('DataFrame-IO') ] ].

		spec
			for: #'pharo7.x'
			do: [
				spec
					package: 'DataFrame-Pharo67' ].

		spec
			for: #'pharo6.x'
			do: [
				spec
					package: 'DataFrame-Pharo6';
					package: 'DataFrame-Pharo67' ]
]
