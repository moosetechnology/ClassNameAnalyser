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
DMTBuilder >> buildConceptViewModelsFrom: aCollectionOfConcepts using: aPackageClassModels [
	"On enveloppe chaque class du package dans son concept box "
	^(aCollectionOfConcepts collect: [ :eachConcept | | classmodels |
		classmodels := aPackageClassModels select: [ :eachClassmodel | eachClassmodel concept = eachConcept ].
			DMConceptViewModel new
			name: eachConcept;
				classViewModels: (self buildClassViewModelsFrom: classmodels);
				root: (self selectBiggestHierarchyFor: eachConcept);
				color: (self selectColorFor: eachConcept) ])
]

{ #category : #building }
DMTBuilder >> buildConceptualModelFrom: aModel [
	| msePackages famixPackages |
	msePackages := (aModel allModelNamespaces
		ifEmpty: aModel allModelPackages) asMooseGroup.
	famixPackages := (aModel allModelPackages
		ifNil: aModel allModelNamespaces) asMooseGroup.
	aModel class name = 'MooseModel'
		ifTrue: [ self class conceptualmodel: (DMConceptualModel new
				name: aModel name;
				packagemodels:
					(msePackages
						collect: [ :eachPackage | 
							DMPackageModel new
								name: eachPackage name;
								classmodels: (eachPackage classes collect: [ :each | each classmodel ]) ])) ].
	aModel class name = 'FamixStModel'
		ifTrue: [ self class conceptualmodel: (DMConceptualModel new
				name: aModel name;
				packagemodels:
					(famixPackages
						collect: [ :eachPackage | 
							DMPackageModel new
								name: eachPackage name;
								classmodels: (eachPackage classes collect: [ :each | each classmodel ]) ])) ].
		^DMBuilder conceptualmodel
		
]

{ #category : #'as yet unclassified' }
DMTBuilder >> buildRootModelsFrom: aConceptualModel [
	| classmodels rootModels |
	self initialize.
	DMBuilder conceptualmodel: aConceptualModel.
	classmodels := self extractClassModelsFrom: aConceptualModel.
	rootModels := aConceptualModel hierarchies
		collect: [ :eachHierarchy | 
			DMRootModel new
				name: eachHierarchy name;
				subclasses: (classmodels select: [ :eachClass | eachClass root = eachHierarchy ]);
				type:
					(self
						classTypeWithSubclasses: (classmodels select: [ :eachClass | eachClass root = eachHierarchy ]));
				color:
					(self
						attributeColorByType:
							(self
								classTypeWithSubclasses: (classmodels select: [ :eachClass | eachClass root = eachHierarchy ]))) ].
	
	self class rootmodels: rootModels.
	^ rootModels
]

{ #category : #'as yet unclassified' }
DMTBuilder >> buildViewModelFrom: aConceptualModel using: itsRootModels [
	| aViewModel |
	aViewModel := DMViewModel new.
	aViewModel
	name: aConceptualModel name;
		packageViewModels:
			(aConceptualModel packagemodels
				collect: [ :eachPackageModel | 
					DMPackageViewModel new
						name: eachPackageModel name;
						conceptViewModels:
							(self
								buildConceptViewModelsFrom: (eachPackageModel classmodels collect: #concept)
								using: eachPackageModel classmodels) ]);
		rootmodels: itsRootModels.
	^ aViewModel
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
