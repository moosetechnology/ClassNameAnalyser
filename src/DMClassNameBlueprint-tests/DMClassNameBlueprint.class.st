Class {
	#name : #DMClassNameBlueprint,
	#superclass : #TestCase,
	#instVars : [
		'classNameBlueprintBuilder'
	],
	#category : #'DMClassNameBlueprint-tests'
}

{ #category : #running }
DMClassNameBlueprint >> setUp [ 
	classNameBlueprintBuilder := DMClassNameBlueprintBuilder new.
]

{ #category : #tests }
DMClassNameBlueprint >> testBuildModelFrom [
	| featureSelector conceptualModel viewModel actualPackageNames expectedPackageNames 		expectedConcepts actualConcepts|
	classNameBlueprintBuilder := DMClassNameBlueprintBuilder new.
	viewModel := DMViewModel new.
	actualPackageNames := OrderedCollection new.
	expectedPackageNames := OrderedCollection new.	
	featureSelector := DMFeatureSelector new.
	featureSelector
		filterAllDigits: true;
		stem: true;
		selectLastSymbol: true.
	conceptualModel := featureSelector
		applyFeaturesOn: {'Kernel' . 'DMConceptualModel'}.
	viewModel := classNameBlueprintBuilder buildModelFrom: conceptualModel.
	expectedPackageNames := conceptualModel packages.
	actualPackageNames := (viewModel packageViewModels collect: [ :aPackageViewModel | 	aPackageViewModel packageName ]).
	expectedConcepts := (conceptualModel packageModels
				collect: [ :aPackageModel | 
					aPackageModel classModels
						collect: [ :aClassModel | aClassModel concept ] ]).
	actualConcepts := (viewModel packageViewModels
				collect: [ :aPackageViewModel | 
					aPackageViewModel conceptViewModels
						collect: [ :aConceptViewModel | aConceptViewModel title ] ]).
	self assert:	actualPackageNames equals: expectedPackageNames.
	self assert: actualConcepts equals: expectedConcepts.

]

{ #category : #tests }
DMClassNameBlueprint >> testCreateClassViewModels [

	| featureSelector conceptualModel classViewModels packageModel classModels |
	featureSelector := DMFeatureSelector new.
	featureSelector  
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'Kernel'}.
	packageModel := conceptualModel packageModels at: 1.
	classModels := packageModel classModels.
	classViewModels := classNameBlueprintBuilder createClassViewModelsFrom: classModels.
	self assert: (classViewModels collect: [ :aClassViewModel | aClassViewModel theClass ]) equals: 
	(classModels collect: [ :aClassModel | aClassModel theClass  ])
	
	

]

{ #category : #tests }
DMClassNameBlueprint >> testCreateConceptsViewModels [

	| featureSelector conceptualModel conceptsViewModels packageModel expectedConceptsBag 	actualConceptsBag expectedClasses actualClasses  actualClassViewModels |
	featureSelector := DMFeatureSelector new.
	featureSelector  
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'Kernel'}.
	packageModel := conceptualModel packageModels at: 1.
	conceptsViewModels := classNameBlueprintBuilder createConceptsViewModelsFrom: packageModel.
	actualConceptsBag := (conceptsViewModels collect: [ :aConceptViewModel | aConceptViewModel  	conceptsName ]) asBag.
	expectedConceptsBag := classNameBlueprintBuilder extractConceptsFrom: packageModel.
	
	actualClassViewModels := (conceptsViewModels flatCollect: [ :aConceptViewModel | 	
		aConceptViewModel classViewModels ]) asOrderedCollection.
	actualClasses := actualClassViewModels collect: [ :aClassViewModel | aClassViewModel theClass ].
	expectedClasses := (packageModel classModels collect: [ :aClassModel | aClassModel theClass ]) .
	
	self assert: actualConceptsBag equals: expectedConceptsBag.
	self assert: actualClasses size equals: expectedClasses asOrderedCollection size.
	

]

{ #category : #tests }
DMClassNameBlueprint >> testCreatePackageModeView [

	| featureSelector conceptualModel packageModels actualPackageViewModels viewModel actualConceptsBag expectedConceptsBag actualConceptsViewModels actualPackageNames expectedPackageNames |
	featureSelector := DMFeatureSelector new.
	featureSelector  
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'Kernel' . 'DMFeatureSelector'}.
	packageModels := conceptualModel packageModels.
	viewModel := DMViewModel new.
	viewModel packageViewModels: (classNameBlueprintBuilder createPackageViewModelsFrom: packageModels).
	actualPackageViewModels := viewModel packageViewModels.
	actualPackageNames := actualPackageViewModels collect: [ :aPackageViewModel | aPackageViewModel packageName ].
	actualConceptsViewModels := (actualPackageViewModels flatCollect: [ :aPackageViewModel | aPackageViewModel conceptViewModels ]) asOrderedCollection.
	actualConceptsBag := (actualConceptsViewModels collect: [ :aConceptViewModel | aConceptViewModel conceptsName ]) asBag.
	expectedConceptsBag := (packageModels flatCollect: [ :aPackageModel | 
		classNameBlueprintBuilder extractConceptsFrom: aPackageModel ]) asOrderedCollection.
	expectedPackageNames := { 'Kernel' . 'DMFeatureSelector' }.
	self assert: actualPackageViewModels size equals: packageModels size.
	self assert: actualPackageNames equals: expectedPackageNames.
	self assert: actualConceptsBag equals: expectedConceptsBag asBag .

]

{ #category : #tests }
DMClassNameBlueprint >> testExtractConceptsFromAPackageModel [

	| conceptualModel featureSelector actualConceptsBags expectedConceptsBags aPackageModel |
	featureSelector := DMFeatureSelector new.
	featureSelector  
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'Kernel'}.
	aPackageModel := conceptualModel packageModels at: 1.
	actualConceptsBags := classNameBlueprintBuilder extractConceptsFrom: aPackageModel.
	expectedConceptsBags := ((RPackageOrganizer default packageNamed: 'Kernel') definedClasses 	asOrderedCollection  collect: [ :aClass | 	(featureSelector extractConceptFrom: (aClass asString)) ]) asBag.
	self assert: actualConceptsBags equals: expectedConceptsBags 
	
	
	
]
