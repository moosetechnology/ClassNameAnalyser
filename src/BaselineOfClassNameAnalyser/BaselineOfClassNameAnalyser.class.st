Class {
	#name : #BaselineOfClassNameAnalyser,
	#superclass : #BaselineOf,
	#category : #BaselineOfClassNameAnalyser
}

{ #category : #baselines }
BaselineOfClassNameAnalyser >> baseline: spec [
	<baseline>
	spec for: #common do: [
		"External dependencies"
		self loadCSVGenerator: spec.
		self loadFileDialog: spec.
		"Packages"
		spec
			package: 'CNBFeatureSelector';
			package: 'CNBFeatureSelector-Tests' with: [ spec requires: #('CNBFeatureSelector') ];
			package: 'CNBModels' with: [ spec requires: #('CNBFeatureSelector') ];
			package: 'CNBBuilder'  with: [ spec requires: #('CNBModels') ];
			package: 'CNBBuilder-Tests' with: [ spec requires: #('CNBBuilder') ];
			package: 'CNB-Core' with: [ spec requires: #('CNBBuilder' 'CNBVisualization') ];
			package: 'CNBPatterns' with: [ spec requires: #('CNBModels')  ];
			package: 'CNBPatterns-Tests' with: [ spec requires: #('CNBPatterns') ];
			package: 'CNBProjectImporter' with: [ spec requires: #('CNBModels') ];
			package: 'CNBSpec' with: [ spec requires: #('CNB-Core') ];
			package: 'CNBVisualization' with: [ spec requires: #('CNBProjectImporter') ].
				 ].
]

{ #category : #'as yet unclassified' }
BaselineOfClassNameAnalyser >> loadCSVGenerator: spec [

		spec
			baseline: 'CSVGenerator'
			with: [ spec repository: 'github://NourDjihan/CSVGenerator/src' ].
]

{ #category : #'as yet unclassified' }
BaselineOfClassNameAnalyser >> loadFileDialog: spec [ 

	spec
			baseline: 'FileDialog'
			with: [ spec repository: 'github://Ducasse/file-dialog/repository' ].
]

{ #category : #'as yet unclassified' }
BaselineOfClassNameAnalyser >> loadRoassal3: spec [

	spec
		baseline: 'Roassal3'
		with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ].
]

{ #category : #'as yet unclassified' }
BaselineOfClassNameAnalyser >> pharoVersionsFrom: aVersion [
    ^ (aVersion to: SystemVersion current major) collect: [ :v | ('pharo' , v asString , '.x') asSymbol ]
]
