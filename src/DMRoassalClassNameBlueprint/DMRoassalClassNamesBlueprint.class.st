Class {
	#name : #DMRoassalClassNamesBlueprint,
	#superclass : #Object,
	#instVars : [
		'orderBySize',
		'orderByColor'
	],
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #accessing }
DMRoassalClassNamesBlueprint >> orderByColor [
	orderByColor := true
]

{ #category : #accessing }
DMRoassalClassNamesBlueprint >> orderBySize [
	orderBySize := true
]

{ #category : #visualization }
DMRoassalClassNamesBlueprint >> visualize: aViewModel [
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
					'Concept: ' , conceptVM label , ' ; Dominant hierarchy:'
						, conceptVM root name ].
			 (orderBySize isNotNil
				ifTrue: [  pVM conceptViewModels: (pVM modelsOrderedDescending collect: [ :each | each ]).
					orderByColor isNotNil
					ifTrue: [ pVM conceptViewModels: (pVM modelsOrderedDescending collect: [ :eachConcept | eachConcept ]).
						pVM conceptViewModels: (pVM modelsOrderedByColor collect: [ :each | each ])
						 ]
					  ]
				ifFalse: [ orderByColor isNotNil
					ifTrue: [ pVM conceptViewModels: (pVM modelsOrderedByColor collect: [ :each | each ]) ]
					ifFalse: [ pVM conceptViewModels: (pVM conceptViewModels collect: [ :each | each ]) ]			
					 ]				
				).
				b nodes: (pVM conceptViewModels collect: [ :each | each ] )
				forEach: [ :conceptVM | 
					b shape rectangle
						width: [ :aClass | aClass width ]; height: [ :aClass | aClass height ];
						borderWidth: [ :aclass | aclass borderWidth ];
						borderColor: [ Color black ];
						color: [ :classVM | Color named: classVM color ].
					b nodes: (conceptVM classViewModels collect: [ :aClassVm | aClassVm ]).
					b layout grid ].
			b layout grid ].
	b layout flow.
	b build.
	^ b view
]
