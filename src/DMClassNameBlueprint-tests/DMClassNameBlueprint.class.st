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
DMClassNameBlueprint >> testAttributeColors [

	| featureSelector conceptualModel actualRootClasses actualRootClassesColors |
	featureSelector := DMFeatureSelector new.
	featureSelector 
	stem: true;
	selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel'  }.
	actualRootClasses := classNameBlueprintBuilder extractAllRootClassesFrom: conceptualModel.
	actualRootClassesColors := classNameBlueprintBuilder attributeColorsTo: actualRootClasses asOrderedCollection.
	
]

{ #category : #tests }
DMClassNameBlueprint >> testBuildModelFrom [
	
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
	
	self assert: (classViewModels collect: [ :aClassViewModel | aClassViewModel theClass ]) equals: 
	(classModels collect: [ :aClassModel | aClassModel theClass  ]).
	self assert: (classViewModels collect: [ :aClassViewModel | featureSelector extractRootClassFrom: 	aClassViewModel theClass]) asOrderedCollection equals:( classNameBlueprintBuilder rootClasses 	asOrderedCollection).
	

]

{ #category : #tests }
DMClassNameBlueprint >> testCreateConceptsViewModels [

	| featureSelector conceptualModel conceptsViewModels packageModel expectedConceptsBag 	actualConceptsBag expectedClasses actualClasses  actualClassViewModels |
	featureSelector := DMFeatureSelector new.
	featureSelector  
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'Kernel'}.
	packageModel := conceptualModel packageModels at: 1.
	classNameBlueprintBuilder rootClasses: (classNameBlueprintBuilder extractAllRootClassesFrom: 	conceptualModel).
	classNameBlueprintBuilder rootClassesColors: (classNameBlueprintBuilder attributeColorsTo: 	(classNameBlueprintBuilder rootClasses) ).
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
DMClassNameBlueprint >> testCreatePackageViewModel [

	| featureSelector conceptualModel packageModels actualPackageViewModels viewModel actualConceptsBag 	expectedConceptsBag actualConceptsViewModels actualPackageNames expectedPackageNames 	packageViewModel  conceptsOfAPackageViewModel |
	featureSelector := DMFeatureSelector new.
	featureSelector  
		selectLastSymbol: true.
	conceptualModel := featureSelector applyFeaturesOn: {'Kernel' . 'DMFeatureSelector'}.
	packageModels := conceptualModel packageModels.
	viewModel := DMViewModel new.
	classNameBlueprintBuilder rootClasses: (classNameBlueprintBuilder extractAllRootClassesFrom: 	conceptualModel).
	classNameBlueprintBuilder rootClassesColors: (classNameBlueprintBuilder attributeColorsTo: 	(classNameBlueprintBuilder rootClasses) ).
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
