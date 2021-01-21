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
DMTBuilder >> doConceptViewModelsOf: aPackageModel using: aCollectionOfRoots [
	"On enveloppe chaque class du package dans son concept box "
	| concepts classModels |
	classModels :=(aPackageModel collect: #classModels). 
	concepts := classModels collect: #concept.
	^(concepts asSet collect: [ :eachConcept | | classmodels itsRoot |
		classmodels := classModels select: [ :eachClassmodel | eachClassmodel concept = eachConcept ].
		itsRoot := aCollectionOfRoots detect: [ :aRoot | aRoot concepts = eachConcept ].
			DMConceptViewModel new
			name: eachConcept;
				classViewModels: (self doClassViewModelsFrom: classmodels);
				root: itsRoot;
				color: itsRoot color])
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
