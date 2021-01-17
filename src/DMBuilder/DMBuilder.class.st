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

{ #category : #building }
DMBuilder class >> build: aConceptualModel [ 
	^ self new 
		build: aConceptualModel 
	
]

{ #category : #'as yet unclassified' }
DMBuilder class >> buildRootsOf: aMooseModel accordingto: aMotherClass [
	^self new
		buildRootsOf: aMooseModel accordingto: aMotherClass  
]

{ #category : #accessing }
DMBuilder class >> conceptualmodel [
	^conceptualmodel 
]

{ #category : #accessing }
DMBuilder class >> conceptualmodel: aConceptualModel [ 
	conceptualmodel := aConceptualModel 
]

{ #category : #'as yet unclassified' }
DMBuilder class >> doPackageModelsUsing: packages [
^ packages collect: [ :eachPackage | 
					DMPackageModel new
						name: eachPackage name;
						classmodels: (eachPackage classes collect: [ :each | each classmodel ]) ]
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

{ #category : #sorting }
DMBuilder class >> sort: aCollection [ 

	^self new
		sortAccordingToPalette: aCollection 
]

{ #category : #coloring }
DMBuilder >> aColorFromPalette [

	"we have 24 important colors"
	index := index +1.
	(index <= 24)
	ifTrue: [ ^palette at: index ].
	
	^#black
]

{ #category : #coloring }
DMBuilder >> attributeColorByType: aType [

	(aType = #Trait)
	ifTrue: [ ^ #white ].
	
	(aType = #monoClass)
	ifTrue: [ ^ #white ].
	
	(aType = #monoSuffix)
	ifTrue: [ ^#gray ].
	
	(aType = #multiSuffix)
	ifTrue: [ ^self aColorFromPalette ].
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

{ #category : #building }
DMBuilder >> build: aConceptualModel [
	aConceptualModel buildRootModels.
	aConceptualModel buildPackageModels.  
]

{ #category : #buildRootModels }
DMBuilder >> buildRootModelsFrom: aConceptualModel [
	| rootModels coloredRootModels |
	self initialize.
	self class conceptualmodel: aConceptualModel.
	coloredRootModels := Set new.
	rootModels := aConceptualModel initializeRootModels.
	coloredRootModels := self color: rootModels.
		self class rootmodels: coloredRootModels.
	self attributeSuffixesToTheirRoots. 
	self class rootmodels do: [ :aRoot | aRoot initializeConcepts ].  
	^ self class rootmodels
]

{ #category : #'as yet unclassified' }
DMBuilder >> buildRootsOf: aMooseModel accordingto: aMotherClass [
	self initialize.
]

{ #category : #'as yet unclassified' }
DMBuilder >> buildViewModelFrom: aConceptualModel [
	
	^(DMViewModel new 
	name: aConceptualModel name;
		packageViewModels: (self buildPackageViewModelsFrom: aConceptualModel models);
		rootmodels: self class rootmodels )
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

{ #category : #'as yet unclassified' }
DMBuilder >> extractClassModelsFrom: aConceptualModel [

	^(aConceptualModel models flatCollect: [ :eachPackageModel | eachPackageModel classmodels ]) asOrderedCollection 
]

{ #category : #'as yet unclassified' }
DMBuilder >> extractClassViewModelsFrom: aViewModel [

	^(aViewModel models flatCollect: [ :eachPackageViewModel |  eachPackageViewModel models flatCollect: #models])
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

{ #category : #buildRootModels }
DMBuilder >> initializeRootModelsUsing: aConceptualModel [
	| classmodels |
	classmodels := aConceptualModel allClassModels. 
	^ (aConceptualModel hierarchies
		collect: [ :eachHierarchy | 
			| hierarchyClasses |
			hierarchyClasses := classmodels
				select: [ :eachClass | eachClass root = eachHierarchy ].
			DMRootModel new
				name: eachHierarchy name;
				size: hierarchyClasses size;
				subclasses: hierarchyClasses;
				suffixes: hierarchyClasses;
				type: (self classTypeWithSubclasses: hierarchyClasses) ])
]

{ #category : #'as yet unclassified' }
DMBuilder >> selectBiggestHierarchyFor: aConcept [ 
	^(self class rootmodels select: [ :aRoot | aRoot concepts includes: aConcept ]) first.
]

{ #category : #sorting }
DMBuilder >> sortAccordingToPalette: aCollection [
	| newPalette |
	newPalette := palette asOrderedCollection.
	newPalette addAll: #(#gray #white #black).
	^((1 to: newPalette size)
		collect: [ :cursor | 
			aCollection
				select: [ :aConceptVM | aConceptVM color = (newPalette at: cursor) ] ]) flattened
]

{ #category : #accessing }
DMBuilder >> sortRootModels [
	self class rootmodels sorted: #size descending
]

{ #category : #accessing }
DMBuilder >> sortRootModels: aSetOfRootModels [
	^(aSetOfRootModels sorted: #size descending)
]
