Class {
	#name : #DMRoassalClassNamesBlueprint,
	#superclass : #Object,
	#instVars : [
		'orderBySize',
		'orderByColor'
	],
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #visualization }
DMRoassalClassNamesBlueprint class >> visualize: aViewModel [
	^ self new
		visualize: aViewModel 
]

{ #category : #initialization }
DMRoassalClassNamesBlueprint >> initialize [
	super initialize.
	"orderBySize := false.
	orderByColor := false."
]

{ #category : #accessing }
DMRoassalClassNamesBlueprint >> models: collectionOfModels [
	^collectionOfModels collect: [ :aModel | aModel ] 
]

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
				[ :packageVM | DMNameAbbreviationCreator abbreviate: packageVM name until: 5 ]
			color: Color black;
		borderColor: Color black.
	b interaction popup text: [ :aPackageVM | aPackageVM name ].
	b
		nodes:
			(orderBySize isNotNil
			ifTrue: [ aViewModel modelsOrderedDescending collect: [ :packageVM | packageVM ]]
			ifFalse: [ self models: aViewModel packageViewModels ])
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
						color: [ :classVM | Color value: classVM color ];
						borderColor: [ :aClassVM | aClassVM borderColor ].
					b nodes: (conceptVM classViewModels collect: [ :aClassVm | aClassVm ]).
					b layout grid ].
			b layout grid ].
	b layout flow.
	b build.
	^ b view
]
