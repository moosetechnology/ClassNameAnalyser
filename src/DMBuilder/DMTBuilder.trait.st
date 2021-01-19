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

{ #category : #'as yet unclassified' }
DMTBuilder >> buildPackageViewModelsFrom: packageModels [

	^(packageModels collect: [ :eachPackageModel | | concepts |
		concepts := (eachPackageModel classModels collect: #concept) asSet.
		DMPackageViewModel new
						name: eachPackageModel name;
						conceptViewModels:
							(self
								buildConceptViewModelsFrom: concepts using: (eachPackageModel classModels)) ])
]

{ #category : #'as yet unclassified' }
DMTBuilder >> buildViewModelFrom: aConceptualModel [
	
	^(DMViewModel new 
	name: aConceptualModel name;
		packageViewModels: (self buildPackageViewModelsFrom: aConceptualModel models);
		rootmodels: self class rootmodels )
]
