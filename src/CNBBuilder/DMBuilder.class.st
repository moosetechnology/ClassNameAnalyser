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

{ #category : #counting }
DMBuilder class >> countIntrudersIn: aViewModel [
	^self new
		countIntrudersIn: aViewModel
]

{ #category : #enumerating }
DMBuilder class >> do: anObject [
	^self new 
		do: anObject
]

{ #category : #doing }
DMBuilder class >> doPackageModelsOf: aModel [

	^self new 
		doPackageModelsOf: aModel 
]

{ #category : #doing }
DMBuilder class >> doPackageViewModelsOf: packageModels [
	^self new
	doPackageViewModelsOf: packageModels 
]

{ #category : #doing }
DMBuilder class >> doPrefixesDictionaryFrom: aCollectionOfClassModels [
	^self new 
	doPrefixesDictionaryFrom: aCollectionOfClassModels

]

{ #category : #doing }
DMBuilder class >> doRootsOf: aCollectionOfClassModels Accordingto: aMotherClass [
	^self new
		doRootsOf: aCollectionOfClassModels Accordingto: aMotherClass  
]

{ #category : #doing }
DMBuilder class >> doSuffixesDictionaryFrom: aCollectionOfClassModels [
	^self new 
	doSuffixesDictionaryFrom: aCollectionOfClassModels

]

{ #category : #extraction }
DMBuilder class >> extractBiggestClassDepthFrom: aConceptualModel [ 
	| classModels |
	classModels := self new 
		extractClassModelsFrom: aConceptualModel.
	^self new 
		extractBiggestClassDepthFrom: classModels.
]

{ #category : #extraction }
DMBuilder class >> extractClassModelsFrom: packageModels [ 	
	^self new
		extractClassModelsFrom: packageModels 
]

{ #category : #extraction }
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
			CNBClassViewModel new create: eachClassModel;
				root: itsRoot;
				originalColor: itsRoot color;
				color: itsRoot color ]
]

{ #category : #accessing }
DMBuilder >> doConceptViewModelsOf: aPackageModel using: rootModels [
	"On enveloppe chaque class du package dans son concept box "

	| concepts |
	concepts := (aPackageModel classModels collect: #suffix) asSet.
	^ concepts
		collect: [ :eachConcept | 
			| classmodels itsRoot |
			itsRoot := self
				selectBiggestHierarchyOf: eachConcept
				using: rootModels.
			classmodels := aPackageModel classModels
				select: [ :eachClassmodel | eachClassmodel suffix = eachConcept ].
			CNBSuffixViewModel new
				package: aPackageModel name;
				name: eachConcept;
				classViewModels: (self doClassViewModelsOf: classmodels using: rootModels);
				root: itsRoot;
				originalColor: itsRoot color;
				color: itsRoot color ]
]

{ #category : #doing }
DMBuilder >> doPackageModelsOf: aViewModel [
	^ aViewModel model packages
		collect: [ :eachPackage | 
			CNBPackageModel 
				of: eachPackage root: aViewModel settings rootClass ]
]

{ #category : #doing }
DMBuilder >> doPackageViewModelsOf: aViewModel [ 

	^(aViewModel packageModels 
		collect: [ :eachPackageModel | 
				CNBPackageViewModel new
					name: eachPackageModel name;
					color: CNBPackageViewModel new defaultColor;
					originalColor: CNBPackageViewModel new defaultColor;
					suffixViewModels:
						(self
							doConceptViewModelsOf: eachPackageModel 
											using: aViewModel rootModels) ])
]

{ #category : #doing }
DMBuilder >> doPrefixesDictionaryFrom: aCollectionOfClassModels [
	| prefixes  concepts |
	prefixes := Dictionary new.
	concepts := (aCollectionOfClassModels collect: #prefix).
	concepts do: [ :aConcept | prefixes at: aConcept put: (concepts occurrencesOf: aConcept) ].
	^prefixes 
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
	concepts := (aCollectionOfClassModels collect: #suffix).
	concepts do: [ :aConcept | suffixes at: aConcept put: (concepts occurrencesOf: aConcept) ].
	^suffixes 
]

{ #category : #extracting }
DMBuilder >> extractConceptsFrom: aPackageModel [

	^aPackageModel classModels collect: [ :aClassModel | aClassModel suffix ]
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
