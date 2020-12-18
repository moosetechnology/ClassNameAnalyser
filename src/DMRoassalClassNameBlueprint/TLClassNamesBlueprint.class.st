Class {
	#name : #TLClassNamesBlueprint,
	#superclass : #TLVisualization,
	#instVars : [
		'packageBoxes',
		'property',
		'innerEntities',
		'propertySortingBlock',
		'innerEntitiesSelector'
	],
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #'as yet unclassified' }
TLClassNamesBlueprint class >> packageBoxes: packages conceptBoxes: concepts classBoxes: classes [

	^self new
	packageBoxes: packages;
	conceptBoxes: concepts;
	classBoxes: classes
	
]

{ #category : #'as yet unclassified' }
TLClassNamesBlueprint class >> packageBoxes: aCollectionOfEntities innerEntities: innerEntitiesPropertyOrBlock property: legendProperty [
	^ self new
		packageBoxes: aCollectionOfEntities;
		innerEntitiesSelector: innerEntitiesPropertyOrBlock;
		property: legendProperty
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
	
	childrenStrategy := (TLNodeCreationStrategy
				composite: [ :children | self innerEntitiesSelector cull: children ]
				withLayout: (TLLinearLayout gap: 20 ratio: 16 / 9)).
				
	(self > #packageBoxes) nodeCreationStrategy
		compositeProperty: [ :box | self innerEntitiesSelector cull: box ];
		childrenStrategy: childrenStrategy.


	((self > #packageBoxes) styleSheet > #children)
		backgroundColor: (self createColorBlock);
		noNodeLabel.
			
	(self > #packageBoxes) styleSheet
		nodeLabel: #name position: #top;
		backgroundColor: Color white.
	self > #packageBoxes addNodesFromEntities: self packageBoxes

	"sort the containers AFTER they are all added to the visualization because the
	sorting is rather heavy, we want to do it once for all"
]

{ #category : #label }
TLClassNamesBlueprint >> configLabelPosition [ 
	(self > #packageBoxes) styleSheet nodeLabelPosition: #top.
]

{ #category : #layout }
TLClassNamesBlueprint >> configLayout [
	"self > #packageBoxes layout: (TLLinearLayout gap: 20 ratio: 16/9).
	self > #conceptBoxes layout: (TLLinearLayout gap: 20 ratio: 16/9).
	self > #classBoxes layout: (TLLinearLayout gap: 20 ratio: 16/9)."
	
	self > #packageBoxes layout: (TLLinearLayout gap: 20 ratio: 16/9).
]

{ #category : #private }
TLClassNamesBlueprint >> createColorBlock [
	^ [ :anEntity | 
	| color |
	color := anEntity color.
	Color named: color ]
]

{ #category : #initialization }
TLClassNamesBlueprint >> defaultColor [
	^ Color black
]

{ #category : #default }
TLClassNamesBlueprint >> defaultTitle [
	^ 'ClassNamesBlueprint'
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
TLClassNamesBlueprint >> innerEntitiesSelector [
	^ innerEntitiesSelector
]

{ #category : #accessing }
TLClassNamesBlueprint >> innerEntitiesSelector: anObject [
	innerEntitiesSelector := anObject
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

{ #category : #accessing }
TLClassNamesBlueprint >> propertySortingBlock [
	^ propertySortingBlock
]

{ #category : #accessing }
TLClassNamesBlueprint >> propertySortingBlock: aBlock [
	propertySortingBlock := aBlock
]

{ #category : #'as yet unclassified' }
TLClassNamesBlueprint >> rootBlackBorder [
	^ [ :anEntity | 
	(anEntity name = anEntity rootname)
	ifTrue: [ ^Color black ]
	]
]
