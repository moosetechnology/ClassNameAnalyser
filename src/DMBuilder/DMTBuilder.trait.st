Trait {
	#name : #DMTBuilder,
	#traits : 'DMTColorAttributor',
	#classTraits : 'DMTColorAttributor classTrait',
	#category : #DMBuilder
}

{ #category : #'as yet unclassified' }
DMTBuilder >> buildClassViewModelsFrom: classmodels [
	^(classmodels collect: [ :eachClassModel | |itsRoot |
		itsRoot := (self class rootmodels detect: [ :eachRootModel | (eachClassModel root) name = eachRootModel name ]).
		DMClassViewModel new 
		name: eachClassModel name;
		reference: eachClassModel reference;
		concept: eachClassModel concept;
		root: eachClassModel root;
		level: eachClassModel level;
		color:  itsRoot color
		 ])
]

{ #category : #'as yet unclassified' }
DMTBuilder >> buildConceptViewModelsFrom: aCollectionOfConcepts using: aPackagesClassModels [
	"On enveloppe chaque class du package dans son concept box "
	^(aCollectionOfConcepts asSet collect: [ :eachConcept | | classmodels |
		classmodels := aPackagesClassModels select: [ :eachClassmodel | eachClassmodel concept = eachConcept ].
			DMConceptViewModel new
			name: eachConcept;
				classViewModels: (self buildClassViewModelsFrom: classmodels);
				root: (self selectBiggestHierarchyFor: eachConcept);
				color: (self selectColorFor: eachConcept) ])
]

{ #category : #building }
DMTBuilder >> buildConceptualModelFrom: aModel [

	self class conceptualmodel: aModel conceptualmodel.
	^ self class conceptualmodel
		
]

{ #category : #'as yet unclassified' }
DMTBuilder >> buildPackageViewModelsFrom: packageModels [

	^(packageModels collect: [ :eachPackageModel | | concepts |
		concepts := (eachPackageModel classmodels collect: #concept) asSet.
		DMPackageViewModel new
						name: eachPackageModel name;
						conceptViewModels:
							(self
								buildConceptViewModelsFrom: concepts using: (eachPackageModel classmodels)) ])
]

{ #category : #'as yet unclassified' }
DMTBuilder >> buildRootModelsFrom: aConceptualModel [
	| classmodels rootModels coloredRootModels sortedRootModels |
	self initialize.
	self class conceptualmodel: aConceptualModel.
	coloredRootModels := Set new.
	classmodels := self extractClassModelsFrom: aConceptualModel.
	rootModels := aConceptualModel hierarchies
		collect: [ :eachHierarchy | 
			DMRootModel new
				name: eachHierarchy name;
				subclasses: (classmodels select: [ :eachClass | eachClass root = eachHierarchy ]);
				type:
					(self
						classTypeWithSubclasses: (classmodels select: [ :eachClass | eachClass root = eachHierarchy ])) ].
	sortedRootModels := self sortRootModels: rootModels.
	coloredRootModels := (sortedRootModels 
		collect: 
			[ :eachRootModel | eachRootModel color: (self attributeColorByType: eachRootModel type) ]).
	self class rootmodels: coloredRootModels.
	^ coloredRootModels
]

{ #category : #'as yet unclassified' }
DMTBuilder >> buildViewModelFrom: aConceptualModel [
	
	^(DMViewModel new 
	name: aConceptualModel name;
		packageViewModels: (self buildPackageViewModelsFrom: aConceptualModel models);
		rootmodels: self class rootmodels )
]

{ #category : #'as yet unclassified' }
DMTBuilder >> classTypeWithSubclasses: anArrayOfClassModelsOfTheSameRoot [
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
