Trait {
	#name : #DMTBuilder,
	#traits : 'DMTColorAttributor',
	#classTraits : 'DMTColorAttributor classTrait',
	#category : #'DMConceptualModel-Traits-Builder'
}

{ #category : #building }
DMTBuilder >> buildClassViewModelsFrom: aCollectionOfClassModels [

	^DMClassModelGroup new addAll: (aCollectionOfClassModels collect: [ :aClassModel | 
		DMClassViewModel new name: (aClassModel name); root: aClassModel root; color: 'not yet identified'; concept: aClassModel name.
		 ]).
]

{ #category : #building }
DMTBuilder >> buildConceptViewModelsFrom: aPackageModel [

	| concepts |
	concepts := (self extractConceptsFrom: aPackageModel) asSet.

	^DMConceptModelGroup new addAll: 
	(concepts collect: [ :aConcept | 
		DMConceptViewModel 
		name: aConcept 
		with: (self buildClassViewModelsFrom: 
		(aPackageModel classmodels 
		select: [ :aClassModel | aClassModel concept = aConcept])).
		 ])
	
]

{ #category : #building }
DMTBuilder >> buildConceptualModelFrom: aMooseModel [

		
		^DMConceptualModel 
		name: aMooseModel name 
		with: (((aMooseModel allModelNamespaces ifEmpty: aMooseModel allModelPackages) asMooseGroup) 		conceptualPackageModels)
]

{ #category : #building }
DMTBuilder >> buildPackageViewModelsFrom: aConceptualModel [
 
	 
	^DMPackageModelGroup new addAll:(
		aConceptualModel packagemodels collect: [ :packageModel | DMPackageViewModel
		name: (packageModel name)
		with: (self buildConceptViewModelsFrom: packageModel)]).
 
]

{ #category : #'as yet unclassified' }
DMTBuilder >> buildPackagesFrom: aConceptualModel [

	| viewmodel |
	viewmodel := DMViewModel new
	name: aConceptualModel name.
	DMHierarchy initializeRoots.
	viewmodel packageViewModels: (self buildPackageViewModelsFrom: aConceptualModel). 
	viewmodel rootmodels: (DMHierarchy rootmodels).
	DMHierarchy rootsANDclasses removeAll.
	^viewmodel 
]

{ #category : #building }
DMTBuilder >> buildRootModelsFrom: aCollectionOfRoots [

	| collection |
	self initialize.
	collection := OrderedCollection new.
	aCollectionOfRoots associationsDo: [ :anAssociation | collection add: (DMRootModel new 
		name: 	anAssociation key name;
		concepts: (anAssociation value collect: [ :each | each concept ]);
		subclasses: (DMClassModelGroup new addAll: (anAssociation value));
		type: 	(self classTypeWithSubclasses: anAssociation value);
		color: (self attributeColorByType: (self classTypeWithSubclasses: anAssociation value)) ). ].
	self initialize.
	^collection.
			

	
]

{ #category : #building }
DMTBuilder >> buildViewModelFrom: aConceptualModel [

	| viewmodel |
	viewmodel := self buildPackagesFrom: aConceptualModel.
	self color: viewmodel.
	^viewmodel
]

{ #category : #actions }
DMTBuilder >> classTypeWithSubclasses: aSet [

	(aSet value isTrait)
	ifTrue: [ ^ #Trait ].
	
	(aSet size == 1)
	ifTrue: [ ^ #monoClass ].
	
	((aSet collect: [ :each | each concept ]) asSet size == 1)
	ifTrue: [ ^ #monoSuffix ].
	
	^ #multiSuffix
]

{ #category : #actions }
DMTBuilder >> extractConceptsFrom: aPackageModel [

	^aPackageModel classmodels collect: [ :aClassModel | aClassModel concept ]
]
