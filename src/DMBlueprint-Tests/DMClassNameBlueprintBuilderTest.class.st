Class {
	#name : #DMClassNameBlueprintBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'classNameBlueprintBuilder',
		'builder',
		'colorAttributor'
	],
	#classInstVars : [
		'classNameBlueprintBuilder'
	],
	#category : #'DMBlueprint-Tests'
}

{ #category : #running }
DMClassNameBlueprintBuilderTest >> setUp [ 
	builder := DMBlueprintBuilder new.
]

{ #category : #tests }
DMClassNameBlueprintBuilderTest >> testBuildModelFromAConceptualModel [
	
	| featureSelector conceptualModel viewModel actualPackageViewNames blueprintBuilder |
	blueprintBuilder := DMBlueprintBuilder new.
	featureSelector := DMFeatureSelector new.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel' }.
	blueprintBuilder orderAttributor orderFromBiggest: true.
	viewModel := blueprintBuilder buildModelFrom: conceptualModel.
	actualPackageViewNames := (viewModel packageViewModels collect: [ :aPackageViewModel | 	aPackageViewModel packageRef ]).
	self assert: actualPackageViewNames equals: { 'Kernel' . 'DMViewModel' } asOrderedCollection.
	self assert: viewModel packageViewModels size equals: conceptualModel packageModels size.
	
]

{ #category : #tests }
DMClassNameBlueprintBuilderTest >> testCreateClassViewModelsFromClassModels [

	| featureSelector conceptualModel classViewModels packageModel classModels conceptViewModel |
	featureSelector := DMFeatureSelector new.
	featureSelector  
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'Kernel'}.
	packageModel := conceptualModel packageModels at: 1.
	classModels := packageModel classModels.
	classViewModels := builder createClassViewModelsFrom: classModels.	
	self assert: (classViewModels collect: [ :aClassViewModel | aClassViewModel classRef ]) equals: 
	(classModels collect: [ :aClassModel | aClassModel classRef  ]).
	

]

{ #category : #tests }
DMClassNameBlueprintBuilderTest >> testCreateConceptsViewModelsFromAPackageModel [

	| featureSelector conceptualModel conceptsViewModels packageModel expectedConcepts 	actualConcepts expectedClasses actualClasses  actualClassViewModels |
	featureSelector := DMFeatureSelector new.
	featureSelector  
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'Kernel'}.
	packageModel := conceptualModel packageModels at: 1.
	conceptsViewModels := builder createConceptsViewModelsFrom: packageModel.
	actualConcepts := (conceptsViewModels collect: [ :aConceptViewModel | aConceptViewModel  	conceptName ]) asSet.
	expectedConcepts := (builder extractConceptsFrom: packageModel) asSet.
	actualClassViewModels := (conceptsViewModels flatCollect: [ :aConceptViewModel | 	
		aConceptViewModel classViewModels ]) asOrderedCollection.
	actualClasses := actualClassViewModels collect: [ :aClassViewModel | aClassViewModel classRef ].
	expectedClasses := (packageModel classModels collect: [ :aClassModel | aClassModel classRef ]) .
	self assert: actualConcepts equals: expectedConcepts.
	self assert: actualClasses size equals: expectedClasses asOrderedCollection size.
	

]

{ #category : #tests }
DMClassNameBlueprintBuilderTest >> testCreatePackageViewModelFromPackageModels [

	| featureSelector conceptualModel packageModels actualPackageViewModels viewModel   	actualConceptsViewModels actualPackageNames expectedPackageNames actualConcepts |
	featureSelector := DMFeatureSelector new.
	featureSelector  
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'Kernel' . 'DMFeatureSelector'}.
	packageModels := conceptualModel packageModels.
	viewModel := DMViewModel new.
	viewModel packageViewModels: (builder createPackageViewModelsFrom: 	packageModels).
	actualPackageViewModels := viewModel packageViewModels.
	actualPackageNames := actualPackageViewModels collect: [ :aPackageViewModel | aPackageViewModel 	packageRef ].
	actualConceptsViewModels := (actualPackageViewModels flatCollect: [ :aPackageViewModel | 	aPackageViewModel conceptViewModels ]) asOrderedCollection.
	actualConcepts := (actualConceptsViewModels collect: [ :aConceptViewModel | aConceptViewModel 	conceptName ]) asSet.
	expectedPackageNames := { 'Kernel' . 'DMFeatureSelector' }.
	self assert: actualPackageViewModels size equals: packageModels size.
	self assert: actualPackageNames equals: expectedPackageNames.

	
]

{ #category : #tests }
DMClassNameBlueprintBuilderTest >> testExtractConceptsFromAPackageModel [

	| conceptualModel featureSelector actualConcepts aViewModel conceptsViewModels  expectedConcepts |
	actualConcepts := Set new.
	colorAttributor := DMColorAttributor new.
	featureSelector := DMFeatureSelector new.
	featureSelector   
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'DMFeatureSelector'}.
	aViewModel := builder buildModelFrom: conceptualModel.	
	actualConcepts := builder extractConceptsFrom: (conceptualModel packageModels at: 1).
	expectedConcepts := colorAttributor extractAllConceptsFrom: aViewModel.
	self assert: actualConcepts asSet equals: expectedConcepts asSet.
	
	
	
]
