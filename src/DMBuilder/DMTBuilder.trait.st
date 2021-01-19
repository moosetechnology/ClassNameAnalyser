Trait {
	#name : #DMTBuilder,
	#traits : 'DMTColorAttributor',
	#classTraits : 'DMTColorAttributor classTrait',
	#category : #DMBuilder
}

{ #category : #'as yet unclassified' }
DMTBuilder >> doClassViewModelsOf: classmodels using: rootModels [
	^(classmodels collect: [ :eachClassModel | |itsRoot |
		itsRoot := (rootModels detect: [ :eachRootModel | (eachClassModel root) name = eachRootModel name ]).
		DMClassViewModel new 
		name: eachClassModel name;
		reference: eachClassModel reference;
		concept: eachClassModel concept;
		root: itsRoot;
		color:  itsRoot color
		 ])
]

{ #category : #'as yet unclassified' }
DMTBuilder >> doConceptViewModelsOf: aCollectionOfConcepts using: aPackagesClassModels [
	"On enveloppe chaque class du package dans son concept box "
	^(aCollectionOfConcepts asSet collect: [ :eachConcept | | classmodels |
		classmodels := aPackagesClassModels select: [ :eachClassmodel | eachClassmodel concept = eachConcept ].
			DMConceptViewModel new
			name: eachConcept;
				classViewModels: (self doClassViewModelsFrom: classmodels);
				root: (self selectBiggestHierarchyFor: eachConcept);
				color: (self selectColorFor: eachConcept) ])
]

{ #category : #'as yet unclassified' }
DMTBuilder >> doPackageViewModelsOf: packageModels [

	^(packageModels collect: [ :eachPackageModel | | concepts |
		concepts := (eachPackageModel classModels collect: #concept) asSet.
		DMPackageViewModel new
						name: eachPackageModel name;
						conceptViewModels:
							(self
								doConceptViewModelsOf: concepts using: (eachPackageModel classModels)) ])
]
