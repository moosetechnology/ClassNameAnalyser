Class {
	#name : #DMClassNamesBlueprint,
	#superclass : #Object,
	#instVars : [
		'viewModel',
		'visualizer'
	],
	#category : #CNBVisualization
}

{ #category : #'as yet unclassified' }
DMClassNamesBlueprint >> description [
| thePackageModels cnbDescription |
	cnbDescription := DMCNBDescriptionModel new.
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
DMClassNamesBlueprint >> initialize [
	super initialize.
	viewModel := DMViewModel new.
	visualizer := DMVisualizer new
]

{ #category : #accessing }
DMClassNamesBlueprint >> model [
	^viewModel model
]

{ #category : #accessing }
DMClassNamesBlueprint >> model: aModel [
	self viewModel model: aModel 
]

{ #category : #accessing }
DMClassNamesBlueprint >> motherRoot [
	^viewModel motherRoot
]

{ #category : #accessing }
DMClassNamesBlueprint >> motherRoot: aClass [ 
	viewModel motherRoot: aClass
]

{ #category : #'as yet unclassified' }
DMClassNamesBlueprint >> orderByColor [ 	
	visualizer orderByColor
]

{ #category : #'as yet unclassified' }
DMClassNamesBlueprint >> orderBySize [
	visualizer orderBySize 
]

{ #category : #accessing }
DMClassNamesBlueprint >> rootModels [ 
	^viewModel rootModels
]

{ #category : #accessing }
DMClassNamesBlueprint >> show [
	^visualizer roassal3View: viewModel 
]

{ #category : #'as yet unclassified' }
DMClassNamesBlueprint >> startBuilding [
	| thePackageModels |
	thePackageModels := (DMBuilder doPackageModelsOf: self viewModel).
	self viewModel 
		name: self model name;
		packageModels: thePackageModels;
		motherRoot: self motherRoot;
		model: self model;
		rootModels: (DMBuilder doRootsOf: (thePackageModels flatCollect: #classModels) Accordingto: 		self motherRoot);
		packageViewModels: (DMBuilder doPackageViewModelsOf: self viewModel).
	 
]

{ #category : #accessing }
DMClassNamesBlueprint >> viewModel [
	^viewModel 
]

{ #category : #accessing }
DMClassNamesBlueprint >> viewModel: aViewModel [
	viewModel := aViewModel 
]
