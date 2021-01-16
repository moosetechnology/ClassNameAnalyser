Class {
	#name : #DMBuilder,
	#superclass : #Object,
	#traits : 'DMTBuilder + DMTColorAttributor + DMTDataExtractor',
	#classTraits : 'DMTBuilder classTrait + DMTColorAttributor classTrait + DMTDataExtractor classTrait',
	#instVars : [
		'palette',
		'index'
	],
	#classInstVars : [
		'rootmodels',
		'conceptualmodel'
	],
	#category : #DMBuilder
}

{ #category : #accessing }
DMBuilder class >> conceptualmodel [
	^conceptualmodel 
]

{ #category : #accessing }
DMBuilder class >> conceptualmodel: aConceptualModel [ 
	conceptualmodel := aConceptualModel 
]

{ #category : #'as yet unclassified' }
DMBuilder class >> extractBiggestClassDepthFrom: aConceptualModel [ 
	| classModels |
	classModels := self new 
		extractClassModelsFrom: aConceptualModel.
	^self new 
		extractBiggestClassDepthFrom: classModels.
]

{ #category : #'as yet unclassified' }
DMBuilder class >> extractClassModelsFrom: aConceptualModel [ 	
	^self new
		extractClassModelsFrom: aConceptualModel 
]

{ #category : #'as yet unclassified' }
DMBuilder class >> extractSmallestClassDepthFrom: aConceptualModel [
	| classModels |
	classModels := self new 
		extractClassModelsFrom: aConceptualModel.
	^self new 
		extractSmallestClassDepthFrom: classModels.

	
]

{ #category : #'as yet unclassified' }
DMBuilder class >> initializeRootModelsUsing: aConceptualModel [
	^self new 
		initializeRootModelsUsing: aConceptualModel
]

{ #category : #accessing }
DMBuilder class >> rootmodels [
	^rootmodels
]

{ #category : #accessing }
DMBuilder class >> rootmodels: collectionOfRootModels [
	rootmodels := collectionOfRootModels 
]

{ #category : #buildRootModels }
DMBuilder >> attributeSuffixesToTheirRoots [
	| concepts |
	concepts := (self class rootmodels flatCollect: [ :each | each suffixes keys ]) asSet.
	concepts do: [ :aConcept | | fighters winner |
		fighters := (self class rootmodels 
		select: [ :aRoot | aRoot suffixes includesKey: aConcept ]) asOrderedCollection.
		(fighters anySatisfy: [ :aRootModel | aRootModel isMultiSuffix ])
			ifTrue: [ fighters removeAllSuchThat: [ :aRootM | aRootM isMonoClass or: aRootM isMonoSuffix ]].
		winner := fighters detectMax: [ :aRM | (aRM suffixes at: aConcept ) value ].
		winner dominantSuffixes: (winner suffixes associationAt: aConcept) ]

]

{ #category : #'as yet unclassified' }
DMBuilder >> classTypeWithSubclasses: anArrayOfClassModelsOfTheSameRoot [
	anArrayOfClassModelsOfTheSameRoot size = 1
		ifTrue: [ (anArrayOfClassModelsOfTheSameRoot at: 1) reference isTrait
				ifTrue: [ ^ #Trait ]
				ifFalse: [ (anArrayOfClassModelsOfTheSameRoot at: 1) root
						= (anArrayOfClassModelsOfTheSameRoot at: 1) reference
						ifTrue: [ ^ #monoClass ] ] ].
				
	((anArrayOfClassModelsOfTheSameRoot collect: [ :each | each concept ])
		asSet size = 1) & ((anArrayOfClassModelsOfTheSameRoot atRandom) concept = (DMFeatureSelector new extractConceptFrom: (anArrayOfClassModelsOfTheSameRoot atRandom) root name))
		ifTrue: [ ^ #monoSuffix ].
	^ #multiSuffix
]

{ #category : #buildRootModels }
DMBuilder >> extractRootModelsFor: aConcept [
	| rootModels |
	rootModels := OrderedCollection new.
	self class rootmodels 
	collect: [ :aRootModel | 
		(aRootModel suffixes includesKey: aConcept)
		ifTrue:[ rootModels add: aRootModel  ]].
	^rootModels 
]

{ #category : #initialize }
DMBuilder >> initialize [

	super initialize.
	palette := {#red . #yellow . #blue . #purple . #magenta . #orange . #green . #pink . #tan  . #cyan . #lightBlue . #lightBrown . #lightCyan  . #lightGreen.
	#lightMagenta . #lightOrange . #lightRed .
	#paleGreen . #paleMagenta . #paleOrange . #palePeach . #paleRed . #paleTan . #black}.
	index := 0.
]

{ #category : #'as yet unclassified' }
DMBuilder >> selectBiggestHierarchyFor: aConcept [ 
	^(self class rootmodels select: [ :aRoot | aRoot concepts includes: aConcept ]).
]

{ #category : #accessing }
DMBuilder >> sortRootModels [
	self class rootmodels sorted: #size descending
]

{ #category : #accessing }
DMBuilder >> sortRootModels: aSetOfRootModels [
	^(aSetOfRootModels sorted: #size descending)
]
