Class {
	#name : #DMRoassalClassNameBlueprint,
	#superclass : #Object,
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #visualization }
DMRoassalClassNameBlueprint >> visualize: aViewModel [
	
	| b colorAttributor featureSelector |
	b := RTMondrian new.
	featureSelector := DMFeatureSelector new.
	colorAttributor := DMColorAttributor new.
	b shape rectangle withTextAbove: [ :packageVM | packageVM packageName ].
	b interaction popup 
		text: [ :aPackageVM | aPackageVM packageName ].
	b
		nodes: (aViewModel packageViewModels collect: [ :packageVM | packageVM ])
		forEach: [ :pVM | 
			b shape rectangle 
			borderColor: [ :aConcept | ((aConcept color = #lightGray) and: [colorAttributor checkIfMonoSuffix: aConcept root])
				ifTrue: [ Color black ]				
					 ];
			color: [ :eachConcept | Color value: eachConcept color ];
			withTextAbove: [ :cpt | cpt conceptName ] color: Color darkGray.
			b interaction popup 
					text: [ :conceptVM | 'Concept: ' , conceptVM conceptName ].
			b nodes: (pVM conceptViewModels collect: [ :conceptVM | conceptVM ])
			forEach: [ :conceptVM | 
				b shape rectangle
				color: [ :classVM | Color value: classVM color ];
				borderColor: [ :aClass | (aClass classRef = (featureSelector extractRootClassFrom: aClass classRef))
					ifTrue: [ Color black ] ifFalse: [(Color value: aClass color) darker ] ].
					
				b interaction popup 
					text: [ :each | each classRef ].
				b 
					nodes: (conceptVM classViewModels collect: [ :classVm | classVm  ]).
					b layout grid.
			  ].
		b layout grid
		].
b layout flow.
b build.
^ b view.

]
