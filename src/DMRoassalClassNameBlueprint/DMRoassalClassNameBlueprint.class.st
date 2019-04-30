Class {
	#name : #DMRoassalClassNameBlueprint,
	#superclass : #Object,
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #visualization }
DMRoassalClassNameBlueprint >> visualize: aViewModel [
	
	| b |
	b := RTMondrian new.
	b shape rectangle withTextAbove: [ :packageVM | packageVM packageName ].
	b interaction popup 
		text: [ :aPackageVM | aPackageVM packageName ].
	b
		nodes: (aViewModel packageViewModels collect: [ :packageVM | packageVM ])
		forEach: [ :pVM | 
			b shape rectangle 
			color: [ :eachConcept | Color value: eachConcept color ];
			withTextAbove: [ :concept | concept conceptName ] color: Color darkGray.
			b interaction popup 
					text: [ :conceptVM | 'Concept: ' , conceptVM conceptName ] .
			b nodes: (pVM conceptViewModels collect: [ :conceptVM | conceptVM ])
			forEach: [ :conceptVM | 
				b shape rectangle
				borderColor: [ :aClassVM | (Color value: aClassVM color) slightlyLighter ];
				color: [ :classVM | Color value: classVM color ].
				b interaction popup 
					text: [ :each | each classRef ].
				b 
					nodes: (conceptVM classViewModels collect: [ :classVm | classVm  ]).
					b layout grid.
			 ].
		b layout grid.
		 ]. 
b layout flow.
b build.
^ b view.

]
