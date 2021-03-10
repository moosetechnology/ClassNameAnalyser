Class {
	#name : #ClassNamesBlueprint,
	#superclass : #Object,
	#instVars : [
		'viewModel',
		'visualizer'
	],
	#category : #'CNB-Core'
}

{ #category : #building }
ClassNamesBlueprint >> build: aViewModel [

	aViewModel startBuilding.
]

{ #category : #description }
ClassNamesBlueprint >> description [
| thePackageModels cnbDescription |
	cnbDescription := CNBDescriptionModel new.
	thePackageModels := (CNBBuilder doPackageModelsOf: self viewModel).
	cnbDescription 
		name: self model name;
		packageModels: thePackageModels;
		rootClass: self rootClass;
		model: self model;
		rootModels: (CNBBuilder doRootsOf: (thePackageModels flatCollect: #classModels) Accordingto: 		self rootClass);
		packageViewModels: (CNBBuilder doPackageViewModelsOf: self viewModel).
		cnbDescription create.
		^cnbDescription 
]

{ #category : #initialization }
ClassNamesBlueprint >> initialize [
	super initialize.
	viewModel := CNBViewModel new.
	visualizer := CNBVisualizer new.

]

{ #category : #accessing }
ClassNamesBlueprint >> model [
	^ viewModel model
]

{ #category : #accessing }
ClassNamesBlueprint >> model: aModel [
	self viewModel model: aModel 
]

{ #category : #'instance creation' }
ClassNamesBlueprint >> on: aCanvas [
	^ CNBRoassal3Builder model: self on: aCanvas 
]

{ #category : #accessing }
ClassNamesBlueprint >> rootModels [ 
	^viewModel rootModels
]

{ #category : #accessing }
ClassNamesBlueprint >> settings [
	^ viewModel settings
]

{ #category : #accessing }
ClassNamesBlueprint >> show [
	^ visualizer roassal3VisualizerShow: 
		(CNBRoassal3Builder new model: self ) 
]

{ #category : #operations }
ClassNamesBlueprint >> startBuilding [
	
	self build: viewModel.
	
]

{ #category : #accessing }
ClassNamesBlueprint >> token: aSymbol [
	viewModel settings token: aSymbol
]

{ #category : #accessing }
ClassNamesBlueprint >> viewModel [
	^ viewModel 
]

{ #category : #accessing }
ClassNamesBlueprint >> viewModel: aViewModel [
	viewModel := aViewModel 
]

{ #category : #'adding/removing' }
ClassNamesBlueprint >> withoutClasses [ 

	viewModel classViewModels do:  [ :each | each border color: Color transparent ]
	
]
