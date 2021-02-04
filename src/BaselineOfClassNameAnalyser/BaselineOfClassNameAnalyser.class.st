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
			package: 'DMModels';
			package: 'DMFeatureSelector' with: [ spec requires: #('DMModels') ];
			package: 'DMFeatureSelector-Tests' with: [ spec requires: #('DMFeatureSelector') ];
			package: 'DMBuilder' with: [ spec requires: #('DMRoassalClassNameBlueprint') ];
			package: 'DMBuilder-Tests' with: [ spec requires: #('DMBuilder') ];
			package: 'DMRoassalClassNameBlueprint' with: [ spec requires: #('DMModels') ].
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
