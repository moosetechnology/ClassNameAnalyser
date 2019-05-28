Class {
	#name : #DMClassNameBlueprintBuilder,
	#superclass : #Object,
	#instVars : [
		'sizeAttributor',
		'orderAttributor',
		'colorAttributor'
	],
	#classInstVars : [
		'conceptsClasses'
	],
	#category : #DMClassNameBlueprint
}

{ #category : #building }
DMClassNameBlueprintBuilder >> buildModelFrom: aConceptualModel [

	| viewModel |
	viewModel := self createViewModelFrom: aConceptualModel.
	viewModel := colorAttributor attributeColors: viewModel.
	viewModel := sizeAttributor attributeSize: viewModel.
	viewModel := orderAttributor setOrder: viewModel.
	^ viewModel 
	
	
]

{ #category : #accessing }
DMClassNameBlueprintBuilder >> colorAttributor [
	^colorAttributor 
]

{ #category : #building }
DMClassNameBlueprintBuilder >> createClassViewModelsFrom: aCollectionOfClassModels [

	| classViewModels |
	classViewModels := aCollectionOfClassModels collect: [ :aClassModel | | aClassViewModel |
		aClassViewModel := DMClassViewModel new.
		aClassViewModel classRef: (aClassModel classRef).
		 ].
	^classViewModels
]

{ #category : #building }
DMClassNameBlueprintBuilder >> createConceptsViewModelsFrom: aPackageModel [

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
DMClassNameBlueprintBuilder >> createPackageViewModelsFrom: aCollectionOfPackageModels [
	
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
DMClassNameBlueprintBuilder >> createViewModelFrom: aConceptualModel [
	
	| aViewModel |
	aViewModel := DMViewModel new.
	aViewModel packageViewModels: (self createPackageViewModelsFrom: aConceptualModel packageModels).
	^aViewModel 
]

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> extractAllClasses: aConceptualModel [

	| classes classMDs |
	classMDs := aConceptualModel packageModels flatCollect: [ :aPackageMD | aPackageMD classModels 		].
	classes := classMDs collect: [ :aClassMD | aClassMD classRef ].
	^classes 
]

{ #category : #actions }
DMClassNameBlueprintBuilder >> extractConceptsFrom: aPackageModel [

	| resultedConcepts |
	resultedConcepts := (aPackageModel classModels collect: [ :aClassModel | aClassModel conceptName ]).
	^resultedConcepts 
]

{ #category : #initialization }
DMClassNameBlueprintBuilder >> initialize [ 
	
	super initialize.
	sizeAttributor := DMSizeAttributor new.
	orderAttributor := DMOrderAttributor new.
	colorAttributor := DMColorAttributor new.
]

{ #category : #accessing }
DMClassNameBlueprintBuilder >> orderAttributor [
	^ orderAttributor
]
