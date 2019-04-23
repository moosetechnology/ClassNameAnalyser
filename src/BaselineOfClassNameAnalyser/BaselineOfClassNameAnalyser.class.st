Class {
	#name : #BaselineOfClassNameAnalyser,
	#superclass : #BaselineOf,
	#category : #BaselineOfClassNameAnalyser
}

{ #category : #baselines }
BaselineOfClassNameAnalyser >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"Dependencies"
		self moose: spec.
				
		"Packages"
		spec 
			package: 'DMConceptualModel';
			package: 'DMFeatureSelector' with: [ spec requires: #('DMConceptualModel') ];
			package: 'DMFeatureSelector-Tests' with: [ spec requires: #('DMFeatureSelector') ];
			package: 'DMViewModel' with: [ spec requires: #('DMConceptualModel') ];
			package: 'DMClassNameBlueprint' with: [ spec requires: #('DMViewModel') ];
			package: 'DMClassNameBlueprint-Tests' with: [ spec requires: #('DMClassNameBlueprint') ];
			package: 'DMRoassalClassNameBlueprint' with: [ spec requires: #('DMClassNameBlueprint') ].
				 ]		

]

{ #category : #'as yet unclassified' }
BaselineOfClassNameAnalyser >> moose: spec [
	
		spec 
			baseline: 'Moose'
			with: [ spec 
								loads: #('Extensions');
								repository:  'github://moosetechnology/Moose:development/src'
								  ]
]
