Class {
	#name : #BaselineOfClassNameAnalyser,
	#superclass : #BaselineOf,
	#category : #BaselineOfClassNameAnalyser
}

{ #category : #baselines }
BaselineOfClassNameAnalyser >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"Packages"
		spec 
			package: 'DMConceptualModel';
			package: 'DMFeatureSelector' with: [ spec requires: #('DMConceptualModel') ];
			package: 'DMFeatureSelector-Tests' with: [ spec requires: #('DMFeatureSelector') ];
			package: 'DMViewModel' with: [ spec requires: #('DMConceptualModel') ];
			package: 'DMClassNameBlueprint' with: [ spec requires: #('DMViewModel') ];
			package: 'DMClassNameBlueprint-Tests' with: [ spec requires: #('DMClassNameBlueprint');
			package: 'DMRoassalClassNameBlueprint' with: [ spec requires: #('DMClassNameBlueprint') ]
						]
					].
			"Dependencies"
			spec for: #(#'Pharo-6.1' #'Pharo64-6.1' ) do: [	
				spec 
				project: 'Moose'
				with: [ spec 
							className: #ConfigurationOfMoose;
							versionString: #'developement';
							repository: 'http://smalltalkhub.com/mc/Moose/Moose/main/'
						 ]
		]
]

{ #category : #baselines }
BaselineOfClassNameAnalyser >> moose: spec [
	
	spec 
				project: 'Moose'
				with: [ spec 
							className: #ConfigurationOfMoose;
							versionString: #'developement';
							repository: 'http://smalltalkhub.com/mc/Moose/Moose/main/'
					 ]				
]
