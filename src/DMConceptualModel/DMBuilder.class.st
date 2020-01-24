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

{ #category : #building }
DMBuilder class >> buildViewModelFrom: aConceptualModel [

	^self new buildViewModelFrom: aConceptualModel
]

{ #category : #'as yet unclassified' }
DMBuilder >> buildClassViewModelsFrom: aCollectionOfClassModels [

	^DMClassModelGroup new addAll: (aCollectionOfClassModels collect: [ :aClassModel | 
		DMClassViewModel new name: (aClassModel name); root: aClassModel root; color: 'not yet identified'
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

{ #category : #building }
DMBuilder >> buildViewModelFrom: aConceptualModel [

	| viewmodel |
	viewmodel := DMViewModel new
	name: aConceptualModel name.
	DMHierarchy initializeRoots.
	viewmodel packageViewModels: (self buildPackageViewModelsFrom: aConceptualModel). 
	viewmodel hierarchies: DMHierarchy rootsANDclasses copy.
	^viewmodel
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
