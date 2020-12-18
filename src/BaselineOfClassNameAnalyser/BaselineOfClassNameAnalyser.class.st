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
	spec loadTelescope: spec.
	
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
BaselineOfClassNameAnalyser >> loadMoose: spec [

            spec
                for: #'pharo6.x'
                do: [ spec
                    project:'Moose'
                    with: [ spec
                        className: #ConfigurationOfMoose;
                        versionString:#'development';
                        repository: 'http://smalltalkhub.com/mc/Moose/Moose/main'] ].
            spec
                for: #'pharo7.x'
                do: [ spec
                    baseline: 'Moose'
                    with: [ spec repository: 'github://moosetechnology/Moose:v7.x.x/src' ] ].
	
				spec 
					for: #'pharo8.x'
					do: [ spec
						baseline: 'Moose'
						with: [ spec repository: 'github://moosetechnology/Moose:development/src' ] ]
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
                    with: [ spec repository: 'github://ObjectProfile/Roassal2/src' ] ] 
]

{ #category : #'as yet unclassified' }
BaselineOfClassNameAnalyser >> loadTelescope: spec [
	spec
		for: #(#'pharo7.x' #'pharo8.x')
		do: [ spec
				baseline: 'Telescope';
				with: [ spec repository: 'github://TelescopeSt/Telescope:v2.x.x/src' ] ]
]

{ #category : #'as yet unclassified' }
BaselineOfClassNameAnalyser >> pharoVersionsFrom: aVersion [
    ^ (aVersion to: SystemVersion current major) collect: [ :v | ('pharo' , v asString , '.x') asSymbol ]
]
