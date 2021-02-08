Class {
	#name : #BaselineOfClassNameAnalyser,
	#superclass : #BaselineOf,
	#category : #BaselineOfClassNameAnalyser
}

{ #category : #baselines }
BaselineOfClassNameAnalyser >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"dependencies"
		"self loadRoassal3: spec."
		"Packages"
		spec 
			package: 'CNBFeatureSelector';
			package: 'CNBFeatureSelector-Tests' with: [ spec requires: #('CNBFeatureSelector') ];
			package: 'CNBModels' with: [ spec requires: #('CNBFeatureSelector') ];
			package: 'CNBBuilder'  with: [ spec requires: #('CNBModels') ];
			package: 'CNBBuilder-Tests' with: [ spec requires: #('CNBBuilder') ];
			package: 'CNBProjectImporter'  with: [ spec requires: #('CNBBuilder') ];
			package: 'CNBVisualization' with: [ spec requires: #('CNBProjectImporter') ].
				 ].
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
