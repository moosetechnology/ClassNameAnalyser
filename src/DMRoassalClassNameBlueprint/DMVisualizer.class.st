Class {
	#name : #DMVisualizer,
	#superclass : #Object,
	#instVars : [
		'orderBySize',
		'orderByColor'
	],
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #accessing }
DMVisualizer >> orderByColor [
	orderByColor := true
]

{ #category : #accessing }
DMVisualizer >> orderBySize [
	orderBySize := true
]

{ #category : #visualization }
DMVisualizer >> visualize: aViewModel [
	| b |
	b := RTMondrian new.
	b shape rectangle
	color: Color white darker;
		withTextAbove:
				[ :packageVM | DMNameAbbreviationCreator abbreviate: packageVM name until: 4 ]
			color: Color black;
		borderColor: Color black.
	b interaction popup text: [ :aPackageVM | aPackageVM name ].
	b
		nodes:
			(orderBySize isNotNil
			ifTrue: [ aViewModel modelsOrderedDescending collect: [ :packageVM | packageVM ]]
			ifFalse: [ aViewModel packageViewModels ])
		forEach: [ :pVM | 
			b shape rectangle
				color: [ :eachConcept | Color value: eachConcept color ];
				borderColor: [ :cvm | cvm borderColor ];
				withTextAbove: [ :cpt | cpt name ] color: Color darkGray.
			b interaction popup
				text: [ :conceptVM | 
					'Concept: ' , conceptVM name , ' ; Dominant hierarchy:'
						, conceptVM root name ].
			 (orderBySize isNotNil
				ifTrue: [  pVM suffixViewModels: (pVM modelsOrderedDescending collect: [ :each | each ]).
					orderByColor isNotNil
					ifTrue: [ pVM suffixViewModels: (pVM modelsOrderedDescending collect: [ :eachConcept | eachConcept ]).
						pVM suffixViewModels: (pVM modelsOrderedByColor collect: [ :each | each ])
						 ]
					  ]
				ifFalse: [ orderByColor isNotNil
					ifTrue: [ pVM suffixViewModels: (pVM modelsOrderedByColor collect: [ :each | each ]) ]
					ifFalse: [ pVM suffixViewModels: (pVM suffixViewModels collect: [ :each | each ]) ]			
					 ]				
				).
				b nodes: (pVM suffixViewModels collect: [ :each | each ] )
				forEach: [ :conceptVM | 
					b shape rectangle
						width: [ :aClass | aClass width ]; height: [ :aClass | aClass height ];
						borderWidth: [ :aclass | aclass borderWidth ];
						borderColor: [ Color black ];
						color: [ :classVM | Color value: classVM color ].
					b nodes: (conceptVM classViewModels collect: [ :aClassVm | aClassVm ]).
					b layout grid ].
			b layout grid ].
	b layout flow.
	b build.
	^ b view
]
