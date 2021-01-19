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

{ #category : #'as yet unclassified' }
DMBuilder class >> buildRootsOf: aCollectionOfClassModels Accordingto: aMotherClass [
	^self new
		buildRootsOf: aCollectionOfClassModels Accordingto: aMotherClass  
]

{ #category : #'as yet unclassified' }
DMBuilder class >> classTypeWithSubclasses: aCollectionOfsubClassModels [
	^self new
	classTypeWithSubclasses: aCollectionOfsubClassModels 
]

{ #category : #'as yet unclassified' }
DMBuilder class >> createSuffixesDictionaryFrom: aCollectionOfClassModels [
	^self new 
	createSuffixesDictionaryFrom: aCollectionOfClassModels

]

{ #category : #enumerating }
DMBuilder class >> do: anObject [
	^self new 
		do: anObject
]

{ #category : #'as yet unclassified' }
DMBuilder class >> doPackageModelsOf: aModel [

	^self new 
		doPackageModelsOf: aModel 
]

{ #category : #'as yet unclassified' }
DMBuilder class >> doPackageViewModelsOf: packageModels [
	^self new
	doPackageViewModelsOf: packageModels 
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
DMBuilder class >> extractClassModelsFrom: packageModels [ 	
	^self new
		extractClassModelsFrom: packageModels 
]

{ #category : #'as yet unclassified' }
DMBuilder class >> extractSmallestClassDepthFrom: aConceptualModel [
	| classModels |
	classModels := self new 
		extractClassModelsFrom: aConceptualModel.
	^self new 
		extractSmallestClassDepthFrom: classModels.

	
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

{ #category : #'as yet unclassified' }
DMBuilder >> buildRootsOf: aCollectionOfClassModels Accordingto: aMotherClass [
	| allRoots initialeRootModels coloredRootModels rootModels |
	self initialize.
	allRoots := aCollectionOfClassModels
		collect: [ :aClassModel | aClassModel root ].
	initialeRootModels := allRoots asSet
		collect: [ :aRootClass | 
			| subclasses |
			subclasses := aCollectionOfClassModels
				select: [ :aClass | aClass root = aRootClass ].
			DMRootModel reference: aRootClass with: subclasses ].
	coloredRootModels := self color: initialeRootModels.
	rootModels := self startFightOverConceptsBetween: coloredRootModels.
	rootModels do: [ :aRootModel | aRootModel initializeConcepts ].
	^rootModels asSet
]

{ #category : #'as yet unclassified' }
DMBuilder >> classTypeWithSubclasses: aCollectionOfSubClassModels [ 
	aCollectionOfSubClassModels size = 1
		ifTrue: [ aCollectionOfSubClassModels first reference isTrait
				ifTrue: [ ^ #Trait ]
				ifFalse: [ (aCollectionOfSubClassModels first root
						= aCollectionOfSubClassModels first reference)
						ifTrue: [ ^ #monoClass ] ] ].
				
	((aCollectionOfSubClassModels collect: [ :each | each concept ])
		asSet size = 1) & ((aCollectionOfSubClassModels atRandom) concept = (DMFeatureSelector extractConceptFrom: (aCollectionOfSubClassModels atRandom) root name))
		ifTrue: [ ^ #monoSuffix ].
	^ #multiSuffix
]

{ #category : #'as yet unclassified' }
DMBuilder >> createSuffixesDictionaryFrom: aCollectionOfClassModels [
	| suffixes concepts |
	suffixes := Dictionary new.
	concepts := (aCollectionOfClassModels collect: #concept).
	concepts do: [ :aConcept | suffixes at: aConcept put: (concepts occurrencesOf: aConcept) ].
	^suffixes 
]

{ #category : #enumerating }
DMBuilder >> do: anObject [
	^anObject startBuilding 
]

{ #category : #'as yet unclassified' }
DMBuilder >> doConceptViewModelsOf: aPackageModel using: rootModels [
	"On enveloppe chaque class du package dans son concept box "

	| concepts |
	concepts := (aPackageModel classModels collect: #concept) asSet.
	^ concepts
		collect: [ :eachConcept | 
			| classmodels itsRoot |
			itsRoot := self
				selectBiggestHierarchyOf: eachConcept
				using: rootModels.
			classmodels := aPackageModel classModels
				select: [ :eachClassmodel | eachClassmodel concept = eachConcept ].
			DMConceptViewModel new
				name: eachConcept;
				classViewModels: (self doClassViewModelsOf: classmodels using: rootModels);
				root: itsRoot;
				color: itsRoot color ]
]

{ #category : #'as yet unclassified' }
DMBuilder >> doPackageModelsOf: aViewModel [
	^ aViewModel model packages
		collect: [ :eachPackage | 
			DMPackageModel new
				name: eachPackage name;
				classModels:
					(eachPackage classes
						collect:
							[ :each | each classModelAccordingTo: aViewModel motherRoot ]) ]
]

{ #category : #'as yet unclassified' }
DMBuilder >> doPackageViewModelsOf: aViewModel [ 

	^(aViewModel packageModels collect: [ :eachPackageModel | 
		DMPackageViewModel new
						name: eachPackageModel name;
						conceptViewModels:
							(self
								doConceptViewModelsOf: eachPackageModel using: aViewModel rootModels) ])
]

{ #category : #'as yet unclassified' }
DMBuilder >> extractClassModelsFrom: packageModels [

	^(packageModels flatCollect: [ :eachPackageModel | eachPackageModel classModels ]) asOrderedCollection 
]

{ #category : #'as yet unclassified' }
DMBuilder >> extractClassViewModelsFrom: aViewModel [

	^(aViewModel models flatCollect: [ :eachPackageViewModel |  eachPackageViewModel models flatCollect: #models])
]

{ #category : #'as yet unclassified' }
DMBuilder >> extractConceptsFrom: aPackageModel [

	^aPackageModel classModels collect: [ :aClassModel | aClassModel concept ]
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
DMBuilder >> selectBiggestHierarchyOf: aConcept using: aCollectioOfRootModels [
	^(aCollectioOfRootModels detect: [ :aRoot | aRoot concepts includes: aConcept ]).
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

{ #category : #'as yet unclassified' }
DMBuilder >> startFightOverConceptsBetween: aCollectionOfRootModels [
	| concepts |
	concepts := (aCollectionOfRootModels flatCollect: [ :each | each suffixes keys ]) asSet.
	concepts do: [ :aConcept | | fighters winner |
		fighters := (aCollectionOfRootModels 
		select: [ :aRoot | aRoot suffixes includesKey: aConcept ]) asOrderedCollection.
		(fighters anySatisfy: [ :aRootModel | aRootModel isMultiSuffix ])
			ifTrue: [ fighters removeAllSuchThat: [ :aRootM | aRootM isMonoClass or: aRootM isMonoSuffix ]].
		winner := fighters detectMax: [ :aRM | (aRM suffixes at: aConcept ) value ].
		winner dominantSuffixes: (winner suffixes associationAt: aConcept) ].
	^aCollectionOfRootModels 

]
