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
	builder := DMClassNamesBlueprintBuilder new.
	colorAttributor := DMColorAttributor new.
]

{ #category : #tests }
DMColorAttributorTest >> testAttributeColorsToACollection [

	| featureSelector conceptualModel  viewModel actualHierarchiesColors hierarchies concepts conceptsHierarchies |
	featureSelector := DMFeatureSelector new.
	featureSelector 
	stem: true.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel'  }.
	viewModel := builder buildModelFrom: conceptualModel.
	hierarchies := colorAttributor  extractAllRootClassesFrom: viewModel.
		concepts := colorAttributor  extractAllConceptsFrom: viewModel.
		conceptsHierarchies:= (concepts collect: [ :aConcept | ((aConcept)->(OrderedCollection new)) ]) 	asDictionary.
	actualHierarchiesColors := colorAttributor setColorsOf: (hierarchies) From: viewModel.
		self assert: actualHierarchiesColors isDictionary equals: true.
	
]

{ #category : #tests }
DMColorAttributorTest >> testCheckIfAllMonoSuffix [
self assert: (colorAttributor checkIfAllMonoSuffix: {DMMalStemmer . Collection} ) equals: false.
self assert: (colorAttributor checkIfAllMonoSuffix: { DMMalStemmer } ) equals: true.
]

{ #category : #tests }
DMColorAttributorTest >> testCheckIfMonoSuffix [

self assert: (colorAttributor checkIfMonoSuffix: DMFeatureSelector) equals: true.
self assert: (colorAttributor checkIfMonoSuffix: Collection) equals: false.
]

{ #category : #tests }
DMColorAttributorTest >> testConceptsClasses [

	| featureSelector conceptualModel viewModel  concepts hierarchies conceptsHierarchies |
	featureSelector := DMFeatureSelector new.
	featureSelector
		stem: true;
		filterAllDigits: true.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel' }.
	viewModel := builder buildModelFrom: conceptualModel.
	hierarchies := colorAttributor  extractAllRootClassesFrom: viewModel.
		concepts := colorAttributor  extractAllConceptsFrom: viewModel.
		conceptsHierarchies:= (concepts collect: [ :aConcept | ((aConcept)->(OrderedCollection new)) ]) 	asDictionary.
	concepts := viewModel packageViewModels collect: [ :aPackageViewModel | aPackageViewModel 	conceptViewModels collect: [ :aConceptViewModel | aConceptViewModel conceptName ] ].
	concepts := concepts flatCollect: [ :each | each ].
		self assert: (concepts includesAll: conceptsHierarchies keys).
		self assert: (conceptsHierarchies keys includesAll: concepts).
		
	
]

{ #category : #tests }
DMColorAttributorTest >> testExtractAllClasses [

	| featureSelector viewModel conceptualModel  |
	
	featureSelector := DMFeatureSelector new.
	conceptualModel := featureSelector applyFeaturesOn: #('AST-Core').
	builder := DMClassNamesBlueprintBuilder new.
	viewModel := builder buildModelFrom: conceptualModel.
	self assert: (colorAttributor extractAllClasses: viewModel ) asSet equals: (RPackageOrganizer default packageNamed: 'AST-Core' ) definedClasses asSet
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
	stem: true.
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
DMColorAttributorTest >> testSelectBiggestHierarchy [

	| aCollection |
	aCollection := { Object . Point . Magnitude . DMFeatureSelector . Point . Object . Point }.
	self assert: (colorAttributor selectBiggestHierarchy: aCollection) equals: Point. 
]
