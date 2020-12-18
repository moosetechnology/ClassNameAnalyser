Class {
	#name : #DMRoassalClassNamesBlueprint,
	#superclass : #Object,
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #visualization }
DMRoassalClassNamesBlueprint >> visualize: aViewModel [
	
	| b |
	b := RTMondrian new.
	b shape rectangle withTextAbove: [ :packageVM | packageVM name ].
	b interaction popup 
		text: [ :aPackageVM | aPackageVM name ].
	b
		nodes: ((aViewModel models sorted: #size descending) collect: [ :packageVM | packageVM ])
		forEach: [ :pVM | 
			b shape rectangle 
			borderColor: [ :aConcept | ((aConcept models collect: #name) includes:  aConcept root name)
				ifTrue: [ Color black ]				
					 ];
			color: [ :eachConcept | (eachConcept root type = #monoSuffix)
				ifTrue: [ Color lightGray ] ifFalse: [ Color value: eachConcept color ] ];
			withTextAbove: [ :cpt | cpt name ] color: Color darkGray.
			b interaction popup 
					text: [ :conceptVM | 'Concept: ' , conceptVM name ].
			b nodes: (pVM models collect: [ :conceptVM | conceptVM ])
			forEach: [ :conceptVM | 
				b shape rectangle
				color: [ :classVM | Color value: classVM color ];
				borderColor: [ :aClass | ((aClass name = conceptVM root name) or: [ (aClass color = #white)  and: [(conceptVM root type == #monoClass)] ])
					ifTrue: [ Color black ] ifFalse: [( Color value: (aClass color)) darker  ]	].
				b nodes: (conceptVM models collect: [ :aClassVm | aClassVm ] ).
				b layout grid.
			  ].
		b layout grid
		].
b layout flow.
b build.
^ b view.
]
