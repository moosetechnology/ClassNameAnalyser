Class {
	#name : #DMRoassalClassNamesBlueprint,
	#superclass : #Object,
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #visualization }
DMRoassalClassNamesBlueprint class >> visualize: aViewModel [
	^ self new
		visualize: aViewModel 
]

{ #category : #visualization }
DMRoassalClassNamesBlueprint >> visualize: aViewModel [
	| b |
	b := RTMondrian new.
	b shape rectangle
		withTextAbove:
				[ :packageVM | DMNameAbbreviationCreator abbreviate: packageVM name until: 5 ]
			color: Color yellow;
		borderColor: Color black;
		color: Color white darker.
	b interaction popup text: [ :aPackageVM | aPackageVM name ].
	b
		nodes:
			(aViewModel modelsOrderedDescending
				collect: [ :packageVM | packageVM ])
		forEach: [ :pVM | 
			b shape rectangle
				color: [ :eachConcept | Color value: eachConcept color ];
				borderColor: [ :cvm | cvm borderColor ];
				withTextAbove: [ :cpt | cpt name ] color: Color darkGray.
			b interaction popup
				text: [ :conceptVM | 
					'Concept: ' , conceptVM name , ' ; Dominant hierarchy:'
						, conceptVM root name ].
			b
				nodes: (pVM modelsOrderedByColor collect: [ :conceptVM | conceptVM ])
				forEach: [ :conceptVM | 
					b shape rectangle
						color: [ :classVM | Color value: classVM color ];
						borderColor: [ :aClassVM | aClassVM borderColor ].
					b nodes: (conceptVM conceptViewModels collect: [ :aClassVm | aClassVm ]).
					b layout grid ].
			b layout grid ].
	b layout flow.
	b build.
	^ b view
]
