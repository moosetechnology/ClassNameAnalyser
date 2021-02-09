Class {
	#name : #DMBuilder,
	#superclass : #Object,
	#traits : 'DMTColorAttributor + DMTDataExtractor',
	#classTraits : 'DMTColorAttributor classTrait + DMTDataExtractor classTrait',
	#classInstVars : [
		'rootmodels',
		'conceptualmodel'
	],
	#category : #CNBBuilder
}

{ #category : #'as yet unclassified' }
DMBuilder class >> countIntrudersIn: aViewModel [
	^self new
		countIntrudersIn: aViewModel
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
DMBuilder class >> doRootsOf: aCollectionOfClassModels Accordingto: aMotherClass [
	^self new
		doRootsOf: aCollectionOfClassModels Accordingto: aMotherClass  
]

{ #category : #'as yet unclassified' }
DMBuilder class >> doSuffixesDictionaryFrom: aCollectionOfClassModels [
	^self new 
	doSuffixesDictionaryFrom: aCollectionOfClassModels

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

{ #category : #accessing }
DMBuilder >> color: rootModels [
	| sortedRootModels coloredRootModels |
	sortedRootModels := self sortRootModels: rootModels.
	coloredRootModels := (sortedRootModels 
		collect: 
			[ :eachRootModel | eachRootModel color: (self assignColorByType: eachRootModel type) ]).
	^coloredRootModels 
	
]

{ #category : #counting }
DMBuilder >> countIntrudersIn: aCnbDescription [

	| conceptVModels intruders conceptIntruders |
	
	intruders := 0.
	conceptVModels := aCnbDescription packageViewModels flatCollect: #suffixViewModels.
	
	conceptVModels do: [ :eachCVM |
		conceptIntruders := eachCVM classViewModels select: [ :cvm |
			cvm root isMonoClass not and: [ 
				cvm root name ~= eachCVM root name ] ].
		
		intruders := intruders + conceptIntruders size ].	
		
	^intruders
	
]

{ #category : #enumerating }
DMBuilder >> do: anObject [
	^anObject startBuilding 
]

{ #category : #accessing }
DMBuilder >> doClassViewModelsOf: classmodels using: rootModels [
	^ classmodels
		collect: [ :eachClassModel | 
			| itsRoot |
			itsRoot := rootModels
				detect: [ :eachRootModel | eachClassModel root name = eachRootModel name ].
			CNBClassViewModel new
				name: eachClassModel name;
				reference: eachClassModel reference;
				concept: eachClassModel concept;
				root: itsRoot;
				color: itsRoot color ]
]

{ #category : #accessing }
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
			CNBSuffixViewModel new
				name: eachConcept;
				classViewModels: (self doClassViewModelsOf: classmodels using: rootModels);
				root: itsRoot;
				color: itsRoot color ]
]

{ #category : #doing }
DMBuilder >> doPackageModelsOf: aViewModel [
	^ aViewModel model packages
		collect: [ :eachPackage | 
			CNBPackageModel 
				of: eachPackage root: aViewModel motherRoot ]
]

{ #category : #doing }
DMBuilder >> doPackageViewModelsOf: aViewModel [ 

	^(aViewModel packageModels 
		collect: [ :eachPackageModel | 
				CNBPackageViewModel new
					name: eachPackageModel name;
					suffixViewModels:
						(self
							doConceptViewModelsOf: eachPackageModel 
											using: aViewModel rootModels) ])
]

{ #category : #doing }
DMBuilder >> doRootsOf: aCollectionOfClassModels Accordingto: aMotherClass [
	| allRoots initialeRootModels coloredRootModels rootModels |
	self initialize.
	allRoots := aCollectionOfClassModels
		collect: [ :aClassModel | aClassModel root ].
	initialeRootModels := allRoots asSet
		collect: [ :aRootClass | 
			| subclasses |
			subclasses := aCollectionOfClassModels
				select: [ :aClass | aClass root = aRootClass ].
			CNBRootModel reference: aRootClass with: subclasses ].
	coloredRootModels := self color: initialeRootModels.
	rootModels := self startFightOverConceptsBetween: coloredRootModels.
	rootModels do: [ :aRootModel | aRootModel initializeConcepts ].
	^ rootModels asSet
]

{ #category : #doing }
DMBuilder >> doSuffixesDictionaryFrom: aCollectionOfClassModels [
	| suffixes concepts |
	suffixes := Dictionary new.
	concepts := (aCollectionOfClassModels collect: #concept).
	concepts do: [ :aConcept | suffixes at: aConcept put: (concepts occurrencesOf: aConcept) ].
	^suffixes 
]

{ #category : #sorting }
DMBuilder >> sortRootModels: aSetOfRootModels [
	^(aSetOfRootModels sorted: #size descending)
]

{ #category : #internal }
DMBuilder >> startFightOverConceptsBetween: aCollectionOfRootModels [
	| concepts |
	concepts := (aCollectionOfRootModels
		flatCollect: [ :each | each suffixes keys ]) asSet.
	concepts
		do: [ :aConcept | 
			| fighters winner |
			fighters := (aCollectionOfRootModels
				select: [ :aRoot | aRoot suffixes includesKey: aConcept ]) copy
				asOrderedCollection.
			(fighters anySatisfy: [ :aRootModel | aRootModel isMultiSuffix ])
				ifTrue: [ fighters removeAllSuchThat: [ :aRootM | aRootM isMonoClass ] ].
			winner := fighters
				detectMax: [ :aRM | (aRM suffixes at: aConcept) value ].
			winner dominantSuffixes: (winner suffixes associationAt: aConcept) ].
	^ aCollectionOfRootModels
]
