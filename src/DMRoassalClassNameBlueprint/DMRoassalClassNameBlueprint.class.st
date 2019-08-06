Class {
	#name : #DMRoassalClassNameBlueprint,
	#superclass : #Object,
	#instVars : [
		'showPackageNames',
		'showConceptNames',
		'showClassNames'
	],
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #visualization }
DMRoassalClassNameBlueprint >> initialize [ 
	super initialize.
	showPackageNames := true.
	showConceptNames := true.
	showClassNames := false.
]

{ #category : #visualization }
DMRoassalClassNameBlueprint >> showClassNames [ 
	^ showClassNames 
]

{ #category : #visualization }
DMRoassalClassNameBlueprint >> showClassNames: aBoolean [
	showClassNames := aBoolean
]

{ #category : #visualization }
DMRoassalClassNameBlueprint >> showConceptNames [
	^ showConceptNames
]

{ #category : #visualization }
DMRoassalClassNameBlueprint >> showConceptNames: aBoolean [
	showConceptNames := aBoolean
]

{ #category : #visualization }
DMRoassalClassNameBlueprint >> showPackageNames [
	^ showPackageNames
]

{ #category : #visualization }
DMRoassalClassNameBlueprint >> showPackageNames: aBoolean [
	showPackageNames := aBoolean
]

{ #category : #visualization }
DMRoassalClassNameBlueprint >> visualize: aViewModel [
	
	| b colorAttributor |
	b := RTMondrian new.
	colorAttributor := DMColorAttributor new.
	b shape rectangle.
	
	self showPackageNames ifTrue: [
		b shape withTextAbove: [ :packageVM | packageVM packageName ] ].
	
	b interaction popup 
		text: [ :aPackageVM | aPackageVM packageName ].
		
	b
		nodes: (aViewModel packageViewModels collect: [ :packageVM | packageVM ])
		forEach: [ :pVM | 
			b shape rectangle 
			borderColor: [ :aConcept | ((aConcept color = #monoHierarchies) and: [colorAttributor checkIfMonoSuffix: aConcept root])
				ifTrue: [ Color black ]				
					 ];
			color: [ :eachConcept | (eachConcept color = #monoHierarchies)
				ifTrue: [ Color lightGray ] ifFalse: [ Color value: eachConcept color ] ].
			
			self showConceptNames ifTrue: [
				b shape
					withTextAbove: [ :cpt | cpt conceptName ]
					color: Color darkGray ].
				
			b interaction popup 
					text: [ :conceptVM | 'Concept: ' , conceptVM conceptName ].
			b nodes: (pVM conceptViewModels collect: [ :conceptVM | conceptVM ])
			forEach: [ :conceptVM | 
				b shape rectangle
				color: [ :classVM | Color value: classVM color ];
				borderColor: [ :aClass | ((aClass classRef) asString = (conceptVM root) asString)  
					ifTrue: [ Color black ] ifFalse: [( Color value: (aClass color)) darker  ]	].
				
				self showClassNames ifTrue: [ 
					b shape withTextAbove: [ :classVM | classVM classRef name ] ].
				
				b nodes: (conceptVM classViewModels collect: [ :aClassVm | aClassVm ] ).
				b layout grid.
			  ].
		b layout grid
		].
b layout flow.
b build.
^ b view.
]
