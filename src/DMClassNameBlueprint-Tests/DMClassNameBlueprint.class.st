Class {
	#name : #DMClassNameBlueprint,
	#superclass : #TestCase,
	#instVars : [
		'classNameBlueprintBuilder'
	],
	#category : #'DMClassNameBlueprint-Tests'
}

{ #category : #running }
DMClassNameBlueprint >> setUp [ 
	classNameBlueprintBuilder := DMClassNameBlueprintBuilder new.
]

{ #category : #tests }
DMClassNameBlueprint >> testAttributeColorsToACollection [

	| featureSelector conceptualModel actualRootClasses actualRootClassesColors |
	featureSelector := DMFeatureSelector new.
	featureSelector 
	stem: true;
	selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel'  }.
	actualRootClasses := classNameBlueprintBuilder extractAllRootClassesFrom: conceptualModel.
	actualRootClassesColors := classNameBlueprintBuilder attributeColorsTo: (actualRootClasses asOrderedCollection).
	
]

{ #category : #tests }
DMClassNameBlueprint >> testBuildModelFromAConceptualModel [
	
	| featureSelector conceptualModel viewModel actualPackageViewNames blueprintBuilder |
	blueprintBuilder := DMClassNameBlueprintBuilder new.
	featureSelector := DMFeatureSelector new.
	featureSelector
		stem: true;
		selectMiddleSymbol: true;
		filterAllDigits: true.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel' }.
	viewModel := blueprintBuilder buildModelFrom: conceptualModel.
	actualPackageViewNames := (viewModel packageViewModels collect: [ :aPackageViewModel | 	aPackageViewModel packageName ]).
	self assert: actualPackageViewNames equals: { 'Kernel' . 'DMViewModel' }.
	self assert: viewModel packageViewModels size equals: conceptualModel packageModels size.
]

{ #category : #tests }
DMClassNameBlueprint >> testConceptsClasses [

	| featureSelector conceptualModel viewModel blueprintBuilder concepts |
	blueprintBuilder := DMClassNameBlueprintBuilder new.
	featureSelector := DMFeatureSelector new.
	featureSelector
		stem: true;
		selectMiddleSymbol: true;
		filterAllDigits: true.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel' }.
	viewModel := blueprintBuilder buildModelFrom: conceptualModel.
	concepts := viewModel packageViewModels collect: [ :aPackageViewModel | aPackageViewModel conceptViewModels collect: [ :aConceptViewModel | aConceptViewModel conceptsName ] ].
	concepts := concepts flatCollect: [ :each | each ].
		self assert: (blueprintBuilder concepts includesAll: blueprintBuilder conceptsClasses keys).
		self assert: (blueprintBuilder conceptsClasses keys includesAll: concepts).
		
	
]

{ #category : #tests }
DMClassNameBlueprint >> testCreateClassViewModelsFromClassModels [

	| featureSelector conceptualModel classViewModels packageModel classModels |
	featureSelector := DMFeatureSelector new.
	featureSelector  
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'Kernel'}.
	packageModel := conceptualModel packageModels at: 1.
	classModels := packageModel classModels.
	classNameBlueprintBuilder rootClasses: (classNameBlueprintBuilder extractAllRootClassesFrom: 	conceptualModel).
	classNameBlueprintBuilder rootClassesColors: (classNameBlueprintBuilder attributeColorsTo: 	(classNameBlueprintBuilder rootClasses) ).
	classViewModels := classNameBlueprintBuilder createClassViewModelsFrom: classModels.
	
	self assert: (classViewModels collect: [ :aClassViewModel | aClassViewModel classRef ]) equals: 
	(classModels collect: [ :aClassModel | aClassModel classRef  ]).
	self assert: (classViewModels collect: [ :aClassViewModel | featureSelector extractRootClassFrom: 	aClassViewModel classRef]) asOrderedCollection equals:( classNameBlueprintBuilder rootClasses 	asOrderedCollection).
	

]

{ #category : #tests }
DMClassNameBlueprint >> testCreateConceptsViewModelsFromAPackageModel [

	| featureSelector conceptualModel conceptsViewModels packageModel expectedConceptsBag 	actualConceptsBag expectedClasses actualClasses  actualClassViewModels |
	featureSelector := DMFeatureSelector new.
	featureSelector  
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'Kernel'}.
	packageModel := conceptualModel packageModels at: 1.
	classNameBlueprintBuilder concept: (classNameBlueprintBuilder extractAllConceptsFrom: conceptualModel).
	classNameBlueprintBuilder rootClasses: (classNameBlueprintBuilder extractAllRootClassesFrom: 	conceptualModel).
	classNameBlueprintBuilder rootClassesColors: (classNameBlueprintBuilder attributeColorsTo: 	(classNameBlueprintBuilder rootClasses) ).
	classNameBlueprintBuilder concepts asBag sortedCounts do: [ :aConceptAssociation | (classNameBlueprintBuilder conceptsClasses add: ((aConceptAssociation 	value)->(OrderedCollection new))) ].
	conceptsViewModels := classNameBlueprintBuilder createConceptsViewModelsFrom: packageModel.
	actualConceptsBag := (conceptsViewModels collect: [ :aConceptViewModel | aConceptViewModel  	conceptsName ]) asSet.
	expectedConceptsBag := (classNameBlueprintBuilder extractConceptsFrom: packageModel) asSet.
	
	actualClassViewModels := (conceptsViewModels flatCollect: [ :aConceptViewModel | 	
		aConceptViewModel classViewModels ]) asOrderedCollection.
	actualClasses := actualClassViewModels collect: [ :aClassViewModel | aClassViewModel classRef ].
	expectedClasses := (packageModel classModels collect: [ :aClassModel | aClassModel classRef ]) .
	
	self assert: actualConceptsBag equals: expectedConceptsBag.
	self assert: actualClasses size equals: expectedClasses asOrderedCollection size.
	

]

{ #category : #tests }
DMClassNameBlueprint >> testCreatePackageViewModelFromPackageModels [

	| featureSelector conceptualModel packageModels actualPackageViewModels viewModel   	actualConceptsViewModels actualPackageNames expectedPackageNames 	packageViewModel 	conceptsOfTheFirstPackageViewModel actualConcepts expectedConcepts |
	featureSelector := DMFeatureSelector new.
	featureSelector  
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'Kernel' . 'DMFeatureSelector'}.
	packageModels := conceptualModel packageModels.
	viewModel := DMViewModel new.
		classNameBlueprintBuilder concept: (classNameBlueprintBuilder extractAllConceptsFrom: 	conceptualModel).
	classNameBlueprintBuilder rootClasses: (classNameBlueprintBuilder extractAllRootClassesFrom: 	conceptualModel).
	classNameBlueprintBuilder rootClassesColors: (classNameBlueprintBuilder attributeColorsTo: 	(classNameBlueprintBuilder rootClasses) ).
	classNameBlueprintBuilder concepts asBag sortedCounts do: [ :aConceptAssociation | (classNameBlueprintBuilder conceptsClasses add: ((aConceptAssociation 	value)->(OrderedCollection new))) ].
	viewModel packageViewModels: (classNameBlueprintBuilder createPackageViewModelsFrom: 	packageModels).
	actualPackageViewModels := viewModel packageViewModels.
	packageViewModel := actualPackageViewModels at: 1.
	conceptsOfTheFirstPackageViewModel := OrderedCollection new.
	conceptsOfTheFirstPackageViewModel := packageViewModel conceptViewModels.
	conceptsOfTheFirstPackageViewModel := conceptsOfTheFirstPackageViewModel collect: [ :each | each conceptsName ].
	actualPackageNames := actualPackageViewModels collect: [ :aPackageViewModel | aPackageViewModel 	packageName ].
	actualConceptsViewModels := (actualPackageViewModels flatCollect: [ :aPackageViewModel | 	aPackageViewModel conceptViewModels ]) asOrderedCollection.
	actualConcepts := (actualConceptsViewModels collect: [ :aConceptViewModel | aConceptViewModel 	conceptsName ]) asSet.
	expectedConcepts := (classNameBlueprintBuilder extractAllConceptsFrom: conceptualModel) asSet.
	expectedPackageNames := { 'Kernel' . 'DMFeatureSelector' }.
	self assert: actualPackageViewModels size equals: packageModels size.
	self assert: actualPackageNames equals: expectedPackageNames.
	self assert: actualConcepts size equals: expectedConcepts size.

	
]

{ #category : #tests }
DMClassNameBlueprint >> testExtractAllConceptsFromaConceptualModel [

	| conceptualModel classes featureSelector expectedConcepts actualConcepts |
	classes := OrderedCollection new.
	featureSelector := DMFeatureSelector new.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' .'DMFeatureSelector' }.
	classes add: (RPackageOrganizer default packageNamed: 'Kernel') definedClasses.
	classes add:(RPackageOrganizer default packageNamed: 'DMFeatureSelector') definedClasses.
	classes := classes flatCollect: [ :packageClasses | packageClasses ].
	expectedConcepts := classes collect: [ :aClass | featureSelector extractConceptFrom: aClass 	asString].
	actualConcepts := classNameBlueprintBuilder extractAllConceptsFrom: conceptualModel.
	self assert: actualConcepts asSet equals: expectedConcepts asSet.
	
]

{ #category : #tests }
DMClassNameBlueprint >> testExtractAllRootClassesFromAConceptualModel [

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
	actualConceptsBags := (classNameBlueprintBuilder extractConceptsFrom: aPackageModel) asBag.
	expectedConceptsBags := ((RPackageOrganizer default packageNamed: 'Kernel') definedClasses 	asOrderedCollection  collect: [ :aClass | 	(featureSelector extractConceptFrom: (aClass asString)) ]) asBag.
	self assert: actualConceptsBags equals: expectedConceptsBags 
	
	
	
]

{ #category : #tests }
DMClassNameBlueprint >> testFindTheColorOfAClassFromThehierarchyColors [

	| classNameBlueprint featureSelector actualColor rootClass  aConceptualModel  expectedColor | 
	featureSelector := DMFeatureSelector new.
	aConceptualModel := featureSelector applyFeaturesOn: { 'Kernel' }.
	classNameBlueprint := DMClassNameBlueprintBuilder new.
	classNameBlueprint rootClassesColors: (classNameBlueprint attributeColorsTo: (classNameBlueprint 	extractAllRootClassesFrom: aConceptualModel)).
	actualColor := classNameBlueprint findColorOf: SimulationExceptionWrapper.
	rootClass := featureSelector extractRootClassFrom: SimulationExceptionWrapper.
	expectedColor := classNameBlueprint findColorOf: rootClass.
	self assert: actualColor equals: expectedColor.

]
