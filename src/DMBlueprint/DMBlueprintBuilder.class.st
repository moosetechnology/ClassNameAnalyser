Class {
	#name : #DMBlueprintBuilder,
	#superclass : #Object,
	#instVars : [
		'sizeAttributor',
		'orderAttributor',
		'colorAttributor'
	],
	#classInstVars : [
		'conceptsClasses'
	],
	#category : #DMBlueprint
}

{ #category : #building }
DMBlueprintBuilder >> buildModelFrom: aConceptualModel [

	| viewModel |
	viewModel := self createViewModelFrom: aConceptualModel.
	viewModel := colorAttributor attributeColors: viewModel.
	viewModel := sizeAttributor attributeSize: viewModel.
	viewModel := orderAttributor setOrder: viewModel.
	^ viewModel 
	
	
]

{ #category : #building }
DMBlueprintBuilder >> createClassViewModelsFrom: aCollectionOfClassModels [

	| classViewModels |
	classViewModels := aCollectionOfClassModels collect: [ :aClassModel | | aClassViewModel |
		aClassViewModel := DMClassViewModel new.
		aClassViewModel classRef: (aClassModel classRef).
		 ].
	^classViewModels
]

{ #category : #building }
DMBlueprintBuilder >> createConceptsViewModelsFrom: aPackageModel [

	| conceptsViewModels packageConcepts |
	conceptsViewModels := OrderedCollection new.
	packageConcepts := (self extractConceptsFrom: aPackageModel) asSet.
	conceptsViewModels := packageConcepts collect: [ :aConcept |
	 | classModels 	aConceptViewModel |
	 classModels := aPackageModel classModels 
		select: [ :aClassModel | aClassModel conceptName = aConcept].
	aConceptViewModel := DMConceptViewModel new.
	aConceptViewModel conceptName: aConcept.
		aConceptViewModel classViewModels: (self createClassViewModelsFrom: (classModels)).
		 ].
	^conceptsViewModels 
]

{ #category : #building }
DMBlueprintBuilder >> createPackageViewModelsFrom: aCollectionOfPackageModels [
	
	| packageViewModels |
	packageViewModels := OrderedCollection new.
	packageViewModels := aCollectionOfPackageModels collect: [ :aPackageModel | | packageViewModel |
		packageViewModel := DMPackageViewModel new.
		packageViewModel packageRef: aPackageModel packageRef.
		packageViewModel conceptViewModels: (self createConceptsViewModelsFrom: aPackageModel).
		 ].
	^packageViewModels 

]

{ #category : #building }
DMBlueprintBuilder >> createViewModelFrom: aConceptualModel [
	
	| aViewModel |
	aViewModel := DMViewModel new.
	aViewModel packageViewModels: (self createPackageViewModelsFrom: aConceptualModel packageModels).
	^aViewModel 
]

{ #category : #actions }
DMBlueprintBuilder >> extractConceptsFrom: aPackageModel [

	| resultedConcepts |
	resultedConcepts := (aPackageModel classModels collect: [ :aClassModel | aClassModel conceptName ]).
	^resultedConcepts 
]

{ #category : #initialization }
DMBlueprintBuilder >> initialize [ 
	
	super initialize.
	sizeAttributor := DMSizeAttributor new.
	orderAttributor := DMOrderAttributor new.
	colorAttributor := DMColorAttributor new.
]

{ #category : #accessing }
DMBlueprintBuilder >> orderAttributor [
	^ orderAttributor
]
