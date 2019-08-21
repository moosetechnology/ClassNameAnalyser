Class {
	#name : #DMRoassalClassNamesBlueprint,
	#superclass : #Object,
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #visualization }
DMRoassalClassNamesBlueprint >> visualize: aViewModel [
	
	| b colorAttributor |
	b := RTMondrian new.
	colorAttributor := DMColorAttributor new.
	b shape rectangle withTextAbove: [ :packageVM | packageVM packageName ].
	b interaction popup 
		text: [ :aPackageVM | aPackageVM packageName ].
	b
		nodes: (aViewModel packageViewModels collect: [ :packageVM | packageVM ])
		forEach: [ :pVM | 
			b shape rectangle 
			borderColor: [ :aConcept | ((aConcept color = #monoHierarchies) and: [ (colorAttributor checkIfMonoSuffix: aConcept root) and: [ aConcept color ~= #white ] ])
				ifTrue: [ Color black ]				
					 ];
			color: [ :eachConcept | (eachConcept color = #monoHierarchies)
				ifTrue: [ Color lightGray ] ifFalse: [ Color value: eachConcept color ] ];
			withTextAbove: [ :cpt | cpt conceptName ] color: Color darkGray.
			b interaction popup 
					text: [ :conceptVM | 'Concept: ' , conceptVM conceptName ].
			b nodes: (pVM conceptViewModels collect: [ :conceptVM | conceptVM ])
			forEach: [ :conceptVM | 
				b shape rectangle
				color: [ :classVM | Color value: classVM color ];
				borderColor: [ :aClass | (((aClass classRef) asString = (conceptVM root) asString) or: [ (aClass color =#white)  and: [(aClass classRef subclasses isEmpty)] ])
					ifTrue: [ Color black ] ifFalse: [( Color value: (aClass color)) darker  ]	].
				b nodes: (conceptVM classViewModels collect: [ :aClassVm | aClassVm ] ).
				b layout grid.
			  ].
		b layout grid
		].
b layout flow.
b build.
^ b view.
]
