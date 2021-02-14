Class {
	#name : #ClassNamesBlueprint,
	#superclass : #Object,
	#instVars : [
		'viewModel',
		'visualizer'
	],
	#category : #CNBModels
}

{ #category : #description }
ClassNamesBlueprint >> description [
| thePackageModels cnbDescription |
	cnbDescription := CNBDescriptionModel new.
	thePackageModels := (DMBuilder doPackageModelsOf: self viewModel).
	cnbDescription 
		name: self model name;
		packageModels: thePackageModels;
		motherRoot: self motherRoot;
		model: self model;
		rootModels: (DMBuilder doRootsOf: (thePackageModels flatCollect: #classModels) Accordingto: 		self motherRoot);
		packageViewModels: (DMBuilder doPackageViewModelsOf: self viewModel).
		cnbDescription create.
		^cnbDescription 
]

{ #category : #initialization }
ClassNamesBlueprint >> initialize [
	super initialize.
	viewModel := CNBViewModel new.
	visualizer := DMVisualizer new
]

{ #category : #accessing }
ClassNamesBlueprint >> model [
	^viewModel model
]

{ #category : #accessing }
ClassNamesBlueprint >> model: aModel [
	self viewModel model: aModel 
]

{ #category : #accessing }
ClassNamesBlueprint >> motherRoot [
	^viewModel motherRoot
]

{ #category : #accessing }
ClassNamesBlueprint >> motherRoot: aClass [ 
	viewModel motherRoot: aClass
]

{ #category : #operations }
ClassNamesBlueprint >> orderByColor [ 	
	visualizer orderByColor
]

{ #category : #operations }
ClassNamesBlueprint >> orderBySize [
	visualizer orderBySize 
]

{ #category : #accessing }
ClassNamesBlueprint >> rootModels [ 
	^viewModel rootModels
]

{ #category : #accessing }
ClassNamesBlueprint >> show [
	^visualizer 
		roassal3VisualizerShow: 
			(CNBRoassal3Builder new 
				model: self ) 
]

{ #category : #operations }
ClassNamesBlueprint >> startBuilding [

	| thePackageModels |
	thePackageModels := DMBuilder doPackageModelsOf: self viewModel.
	self viewModel
		name: self model name;
		packageModels: thePackageModels;
		motherRoot: self motherRoot;
		model: self model;
		rootModels: (DMBuilder
				 doRootsOf: (thePackageModels flatCollect: #classModels)
				 Accordingto: self motherRoot);
		packageViewModels: (DMBuilder doPackageViewModelsOf: self viewModel)
]

{ #category : #accessing }
ClassNamesBlueprint >> viewModel [
	^viewModel 
]

{ #category : #accessing }
ClassNamesBlueprint >> viewModel: aViewModel [
	viewModel := aViewModel 
]

{ #category : #'adding/removing' }
ClassNamesBlueprint >> withoutClasses [ 

	viewModel classViewModels do:  [ :each | each borderColor: Color transparent ]
	
]
