Class {
	#name : #TLClassNamesBlueprint,
	#superclass : #TLVisualization,
	#instVars : [
		'packageBoxes',
		'innerEntities',
		'innerEntitiesPopupBlock',
		'innerEntitiesSelector',
		'property'
	],
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #'as yet unclassified' }
TLClassNamesBlueprint class >> packageBoxes: aCollectionOfEntities innerEntities: innerEntitiesPropertyOrBlock property: legendProperty [
	^ self new
		packageBoxes: aCollectionOfEntities;
		innerEntitiesSelector: innerEntitiesPropertyOrBlock;
		property: legendProperty
]

{ #category : #'as yet unclassified' }
TLClassNamesBlueprint >> borderBlock [
	^[ :anEntity | anEntity borderColor ].
]

{ #category : #building }
TLClassNamesBlueprint >> buildLegend [
	super buildLegend.
	self legend backgroundDescription: [ :entity | (property cull: entity) asString ] forNodes: [ (self > #packageBoxes) allChildrenNodes ]
]

{ #category : #building }
TLClassNamesBlueprint >> buildVisualization [
	| childrenStrategy |
	super buildVisualization.
	childrenStrategy := TLNodeCreationStrategy
		composite: [ :children | self innerEntitiesSelector cull: children ]
		withLayout: (TLLinearLayout gap: 20 ratio: 16 / 9).
		
	(self > #packageBoxes) nodeCreationStrategy
		compositeProperty: [ :box | self innerEntitiesSelector cull: box ];
		childrenStrategy: childrenStrategy.
		
	((self > #packageBoxes) styleSheet > #children)
		backgroundColor: self entityColorBlock;
		borderColor: self borderBlock;
		nodeLabel: self labelBlock position: #bottom.
		
	(self > #packageBoxes) styleSheet
		nodeLabel: #name position: #top;
		backgroundColor: Color white.
		
	self > #packageBoxes addNodesFromEntities: self packageBoxes.
	
	(self > #packageBoxes) allChildrenNodes allChildrenNodes
		addInteraction:
			(TLPopUpAction
				text: [ :entity | self obtain: self innerEntitiesPopupBlock on: entity ])
				onMouseOver
]

{ #category : #label }
TLClassNamesBlueprint >> configLabelPosition [ 
	(self > #packageBoxes) styleSheet nodeLabelPosition: #top.
]

{ #category : #layout }
TLClassNamesBlueprint >> configLayout [
	
	self > #packageBoxes layout: (TLLinearLayout gap: 20 ratio: 16/9).
]

{ #category : #initialization }
TLClassNamesBlueprint >> defaultColor [
	^ Color black
]

{ #category : #default }
TLClassNamesBlueprint >> defaultTitle [
	^ 'ClassNamesBlueprint'
]

{ #category : #private }
TLClassNamesBlueprint >> entityColorBlock [
	^ [ :anEntity | 
	| color |
	color := anEntity color.
	Color named: color ]
]

{ #category : #initialization }
TLClassNamesBlueprint >> initialize [
	super initialize.
	self styleSheet compositeExpandedByDefault: true
]

{ #category : #accessing }
TLClassNamesBlueprint >> innerEntities [
	self deprecated: 'Use #innerEntitiesSelector' transformWith: '`@receiver innerEntities `@statements' -> '`@receiver innerEntitiesSelector'.
	^ self innerEntitiesSelector
]

{ #category : #accessing }
TLClassNamesBlueprint >> innerEntities: anObject [
	self deprecated: 'Use #innerEntitiesSelector:' transformWith: '`@receiver innerEntities: `@statements' -> '`@receiver innerEntitiesSelector: `@statements'.
	^ self innerEntitiesSelector: anObject
]

{ #category : #accessing }
TLClassNamesBlueprint >> innerEntitiesPopupBlock [
	^ innerEntitiesPopupBlock ifNil: [ innerEntitiesPopupBlock := #asString ]
]

{ #category : #accessing }
TLClassNamesBlueprint >> innerEntitiesPopupBlock: anObject [
	innerEntitiesPopupBlock := anObject
]

{ #category : #accessing }
TLClassNamesBlueprint >> innerEntitiesSelector [
	^ innerEntitiesSelector
]

{ #category : #accessing }
TLClassNamesBlueprint >> innerEntitiesSelector: anObject [
	innerEntitiesSelector := anObject
]

{ #category : #accessing }
TLClassNamesBlueprint >> labelBlock [ 

	^[ :anEntity | anEntity label]
]

{ #category : #accessing }
TLClassNamesBlueprint >> packageBoxes [
	^packageBoxes
]

{ #category : #'as yet unclassified' }
TLClassNamesBlueprint >> packageBoxes: packageVModels [
	packageBoxes := packageVModels 
]

{ #category : #accessing }
TLClassNamesBlueprint >> property [
	^ property
]

{ #category : #accessing }
TLClassNamesBlueprint >> property: anObject [
	property := anObject
]
