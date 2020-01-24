Class {
	#name : #DMBuilder,
	#superclass : #Object,
	#instVars : [
		'sizeAttributor',
		'orderAttributor',
		'colorAttributor'
	],
	#classInstVars : [
		'conceptsClasses'
	],
	#category : #DMConceptualModel
}

{ #category : #'as yet unclassified' }
DMBuilder class >> buildConceptualModelFrom: aMooseModel [


	DMHierarchy initialize.
	^self new buildConceptualModelFrom: aMooseModel 
]

{ #category : #'as yet unclassified' }
DMBuilder class >> buildRootModelsFrom: aCollectionOfRoots [

	^self new buildRootModelsFrom: aCollectionOfRoots
]

{ #category : #building }
DMBuilder class >> buildViewModelFrom: aConceptualModel [

	^self new buildViewModelFrom: aConceptualModel
]

{ #category : #'as yet unclassified' }
DMBuilder >> buildClassViewModelsFrom: aCollectionOfClassModels [

	^DMClassModelGroup new addAll: (aCollectionOfClassModels collect: [ :aClassModel | 
		DMClassViewModel new name: (aClassModel name); root: aClassModel root; color: 'not yet identified'; concept: aClassModel name.
		 ]).
]

{ #category : #'as yet unclassified' }
DMBuilder >> buildConceptViewModelsFrom: aPackageModel [

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

{ #category : #'as yet unclassified' }
DMBuilder >> buildConceptualModelFrom: aMooseModel [

		
		^DMConceptualModel 
		name: aMooseModel name 
		with: (((aMooseModel allModelNamespaces ifEmpty: aMooseModel allModelPackages) asMooseGroup) 		conceptualPackageModels)
]

{ #category : #'as yet unclassified' }
DMBuilder >> buildPackageViewModelsFrom: aConceptualModel [
 
	 
	^DMPackageModelGroup new addAll:(
		aConceptualModel packagemodels collect: [ :packageModel | DMPackageViewModel
		name: (packageModel name)
		with: (self buildConceptViewModelsFrom: packageModel)]).
 
]

{ #category : #'as yet unclassified' }
DMBuilder >> buildRootModelsFrom: aCollectionOfRoots [

	aCollectionOfRoots associationsDo: [ :anAssociation | ^(DMRootModel new 
		name: 	anAssociation key name;
		concept: anAssociation key classmodel concept;
		subclasses: (DMClassModelGroup new addAll: (anAssociation value));
		type: 	(self classTypeWithSubclasses: anAssociation value);
		color: 'not yet').
			]

	
]

{ #category : #building }
DMBuilder >> buildViewModelFrom: aConceptualModel [

	| viewmodel |
	viewmodel := DMViewModel new
	name: aConceptualModel name.
	DMHierarchy initializeRoots.
	viewmodel packageViewModels: (self buildPackageViewModelsFrom: aConceptualModel). 
	viewmodel hierarchies: (DMHierarchy rootmodels).
	DMHierarchy rootsANDclasses removeAll.
	^viewmodel
]

{ #category : #'as yet unclassified' }
DMBuilder >> classTypeWithSubclasses: aSet [

	aSet value isTrait
	ifTrue: [ ^ #Trait ].
	
	aSet isEmpty 
	ifTrue: [ ^ #monoClass ].
	
	((aSet collect: [ :each | each concept ]) asSet size == 1)
	ifTrue: [ ^ #monoSuffix ].
	
	^ #multiSuffix
]

{ #category : #accessing }
DMBuilder >> colorAttributor [
	^colorAttributor 
]

{ #category : #actions }
DMBuilder >> extractConceptsFrom: aPackageModel [

	^aPackageModel classmodels collect: [ :aClassModel | aClassModel concept ]
]

{ #category : #accessing }
DMBuilder >> orderAttributor [
	^ orderAttributor
]
