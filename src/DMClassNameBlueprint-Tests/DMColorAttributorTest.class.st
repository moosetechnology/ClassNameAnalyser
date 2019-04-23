Class {
	#name : #DMColorAttributorTest,
	#superclass : #TestCase,
	#instVars : [
		'builder',
		'colorAttributor'
	],
	#category : #'DMClassNameBlueprint-Tests'
}

{ #category : #initialization }
DMColorAttributorTest >> setUp [ 
	builder := DMClassNameBlueprintBuilder new.
	colorAttributor := DMColorAttributor new.
]

{ #category : #tests }
DMColorAttributorTest >> testAttributeColorsToACollection [

	| featureSelector conceptualModel  viewModel actualHierarchiesColors hierarchies concepts conceptsHierarchies |
	featureSelector := DMFeatureSelector new.
	featureSelector 
	stem: true;
	selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel'  }.
	viewModel := builder buildModelFrom: conceptualModel.
	hierarchies := colorAttributor  extractAllRootClassesFrom: viewModel.
		concepts := colorAttributor  extractAllConceptsFrom: viewModel.
		conceptsHierarchies:= (concepts collect: [ :aConcept | ((aConcept)->(OrderedCollection new)) ]) 	asDictionary.
	actualHierarchiesColors := colorAttributor setColorsOf: (hierarchies).
		self assert: actualHierarchiesColors isDictionary equals: true.
	
]

{ #category : #tests }
DMColorAttributorTest >> testConceptsClasses [

	| featureSelector conceptualModel viewModel  concepts hierarchies conceptsHierarchies |
	featureSelector := DMFeatureSelector new.
	featureSelector
		stem: true;
		selectMiddleSymbol: true;
		filterAllDigits: true.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel' }.
	viewModel := builder buildModelFrom: conceptualModel.
	hierarchies := colorAttributor  extractAllRootClassesFrom: viewModel.
		concepts := colorAttributor  extractAllConceptsFrom: viewModel.
		conceptsHierarchies:= (concepts collect: [ :aConcept | ((aConcept)->(OrderedCollection new)) ]) 	asDictionary.
	concepts := viewModel packageViewModels collect: [ :aPackageViewModel | aPackageViewModel 	conceptViewModels collect: [ :aConceptViewModel | aConceptViewModel conceptsName ] ].
	concepts := concepts flatCollect: [ :each | each ].
		self assert: (concepts includesAll: conceptsHierarchies keys).
		self assert: (conceptsHierarchies keys includesAll: concepts).
		
	
]

{ #category : #tests }
DMColorAttributorTest >> testExtractAllConceptsFromaConceptualModel [

	| conceptualModel classes featureSelector expectedConcepts actualConcepts viewModel |
	featureSelector := DMFeatureSelector new.
	classes := OrderedCollection new.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMFeatureSelector' }.
	viewModel := builder buildModelFrom: conceptualModel .
	classes add: (RPackageOrganizer default packageNamed: 'Kernel') definedClasses.
	classes add:(RPackageOrganizer default packageNamed: 'DMFeatureSelector') definedClasses.
	classes := classes flatCollect: [ :packageClasses | packageClasses ].
	expectedConcepts := classes collect: [ :aClass | featureSelector extractConceptFrom: aClass asString ].
	actualConcepts := colorAttributor extractAllConceptsFrom: viewModel .
	self assert: actualConcepts asSet equals: expectedConcepts asSet.
	
]

{ #category : #tests }
DMColorAttributorTest >> testExtractAllRootClassesFromAViewModel [

	| featureSelector conceptualModel actualRootClasses expectedRootClasses classes viewModel |
	classes := OrderedCollection new.
	featureSelector := DMFeatureSelector new.
	featureSelector 
	stem: true;
	selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel'  }.
	viewModel := builder buildModelFrom: conceptualModel.
	actualRootClasses := colorAttributor extractAllRootClassesFrom: viewModel.
	classes add: (RPackageOrganizer default packageNamed: 'DMViewModel') definedClasses.
	classes add: (RPackageOrganizer default packageNamed: 'Kernel') definedClasses.
	classes := classes flatCollect: [ :Classes | Classes ].
	expectedRootClasses := classes collect: [ :aClass | featureSelector extractRootClassFrom: aClass ].
	self assert: actualRootClasses asSet equals: expectedRootClasses asSet.
	
]

{ #category : #tests }
DMColorAttributorTest >> testFindTheColorOfAClassFromThehierarchyColors [

	| featureSelector actualColor rootClass  aConceptualModel  expectedColor aViewModel hierarchies   hierarchiesColors | 
	featureSelector := DMFeatureSelector new.
	aConceptualModel := featureSelector applyFeaturesOn: { 'Kernel' }.
	aViewModel := builder buildModelFrom: aConceptualModel.
	hierarchies := colorAttributor  extractAllRootClassesFrom: aViewModel.
	hierarchiesColors := colorAttributor setColorsOf: (hierarchies).
	actualColor := colorAttributor selectColorOf: SimulationExceptionWrapper From: hierarchiesColors .
	rootClass := featureSelector extractRootClassFrom: SimulationExceptionWrapper.
	expectedColor := colorAttributor selectColorOf: rootClass From:hierarchiesColors.
	self assert: actualColor equals: expectedColor.

]

{ #category : #tests }
DMColorAttributorTest >> testSelectBiggestHierarchy [

	| aCollection |
	aCollection := { Object . Point . Magnitude . DMFeatureSelector . Point . Object . Point }.
	self assert: (colorAttributor selectBiggestHierarchy: aCollection) equals: Point. 
]