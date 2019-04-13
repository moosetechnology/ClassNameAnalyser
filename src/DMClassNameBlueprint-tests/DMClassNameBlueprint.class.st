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
	
	| featureSelector conceptualModel viewModel actualPackageViewNames |
	featureSelector := DMFeatureSelector new.
	featureSelector
		stem: true;
		selectMiddleSymbol: true;
		filterAllDigits: true.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel' }.
	viewModel := classNameBlueprintBuilder buildModelFrom: conceptualModel.
	actualPackageViewNames := (viewModel packageViewModels collect: [ :aPackageViewModel | aPackageViewModel packageName ]).
	self assert: actualPackageViewNames equals: { 'Kernel' . 'DMViewModel' }.
	self assert: viewModel packageViewModels size equals: conceptualModel packageModels size.
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

	| featureSelector conceptualModel packageModels actualPackageViewModels viewModel actualConceptsBag 	expectedConceptsBag actualConceptsViewModels actualPackageNames expectedPackageNames 	packageViewModel  conceptsOfAPackageViewModel |
	featureSelector := DMFeatureSelector new.
	featureSelector  
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'Kernel' . 'DMFeatureSelector'}.
	packageModels := conceptualModel packageModels.
	viewModel := DMViewModel new.
	viewModel packageViewModels: (classNameBlueprintBuilder createPackageViewModelsFrom: 	packageModels).
	actualPackageViewModels := viewModel packageViewModels.
	packageViewModel := actualPackageViewModels at: 1.
	conceptsOfAPackageViewModel := OrderedCollection new.
	conceptsOfAPackageViewModel := packageViewModel conceptViewModels.
	conceptsOfAPackageViewModel := conceptsOfAPackageViewModel collect: [ :each | each conceptsName ].
	actualPackageNames := actualPackageViewModels collect: [ :aPackageViewModel | aPackageViewModel 	packageName ].
	actualConceptsViewModels := (actualPackageViewModels flatCollect: [ :aPackageViewModel | 	aPackageViewModel conceptViewModels ]) asOrderedCollection.
	actualConceptsBag := (actualConceptsViewModels collect: [ :aConceptViewModel | aConceptViewModel 	conceptsName ]) asOrderedCollection.
	expectedConceptsBag := (packageModels flatCollect: [ :aPackageModel | 
		classNameBlueprintBuilder extractConceptsFrom: aPackageModel ]) asOrderedCollection.
	expectedPackageNames := { 'Kernel' . 'DMFeatureSelector' }.
	self assert: actualPackageViewModels size equals: packageModels size.
	self assert: actualPackageNames equals: expectedPackageNames.
	self assert: actualConceptsBag asBag equals: expectedConceptsBag asBag.
	self assert: conceptsOfAPackageViewModel equals: (classNameBlueprintBuilder extractConceptsFrom: 	(conceptualModel packageModels at: 1)).
	
]

{ #category : #tests }
DMClassNameBlueprint >> testExtractAllRootClasses [

	| featureSelector conceptualModel actualRootClasses expectedRootClasses classes |
	classes := OrderedCollection new.
	featureSelector := DMFeatureSelector new.
	featureSelector 
	stem: true;
	selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel'  }.
	actualRootClasses := classNameBlueprintBuilder extractAllRootClassesFrom: conceptualModel.
	classes add: (RPackageOrganizer default packageNamed: 'DMViewModel') definedClasses.
	classes add: (RPackageOrganizer default packageNamed: 'Kernel') definedClasses.
	classes := classes flatCollect: [ :Classes | Classes ].
	expectedRootClasses := classes collect: [ :aClass | featureSelector extractRootClassFrom: aClass ].
	self assert: actualRootClasses asSet equals: expectedRootClasses asSet.
	
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
