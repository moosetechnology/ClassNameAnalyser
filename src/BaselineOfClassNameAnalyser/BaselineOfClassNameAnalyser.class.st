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
		self loadRoassal2: spec.											
		"Packages"
		spec 
			package: 'DMConceptualModel';
			package: 'DMFeatureSelector' with: [ spec requires: #('DMConceptualModel') ];
			package: 'DMFeatureSelector-Tests' with: [ spec requires: #('DMFeatureSelector') ];
			package: 'DMViewModel' with: [ spec requires: #('DMConceptualModel') ];
			package: 'DMClassNameBlueprint' with: [ spec requires: #('DMViewModel') ];
			package: 'DMClassNameBlueprint-Tests' with: [ spec requires: #('DMClassNameBlueprint') ];
			package: 'DMRoassalClassNameBlueprint' with: [ spec requires: #('DMClassNameBlueprint' 'Roassal2' ) ]
				 ].
			

]

{ #category : #'as yet unclassified' }
BaselineOfClassNameAnalyser >> loadRoassal2: spec [
            spec
                for: #'pharo6.x'
                do: [ spec
                    project:'Roassal2'
                    with: [ spec
                        className: #ConfigurationOfRoassal2;
                        versionString:#'stable';
                        repository: 'https://smalltalkhub.com/mc/ObjectProfile/Roassal2/main'] ].
            spec
                for:#(#'pharo7.x' #'pharo8.x')
                do: [ spec
                    baseline: 'Roassal2'
                    with: [ spec repository: 'github://ObjectProfile/Roassal2/src' ].] 
]

{ #category : #'as yet unclassified' }
BaselineOfClassNameAnalyser >> pharoVersionsFrom: aVersion [
    ^ (aVersion to: SystemVersion current major) collect: [ :v | ('pharo' , v asString , '.x') asSymbol ]
]
