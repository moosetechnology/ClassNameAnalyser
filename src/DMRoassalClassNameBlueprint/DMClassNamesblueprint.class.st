Class {
	#name : #DMClassNamesblueprint,
	#superclass : #Object,
	#instVars : [
		'viewModel',
		'orderByColor',
		'orderBySize'
	],
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #initialization }
DMClassNamesblueprint >> initialize [
	super initialize.
	orderBySize := false.
	orderByColor := false.
	viewModel := DMViewModel new
]

{ #category : #accessing }
DMClassNamesblueprint >> model [
	^viewModel model
]

{ #category : #accessing }
DMClassNamesblueprint >> model: aModel [
	self viewModel model: aModel 
]

{ #category : #'as yet unclassified' }
DMClassNamesblueprint >> motherRoot [
	^viewModel motherRoot
]

{ #category : #'as yet unclassified' }
DMClassNamesblueprint >> motherRoot: aClass [ 
	viewModel motherRoot: aClass
]

{ #category : #accessing }
DMClassNamesblueprint >> orderByColor [
	orderByColor := true
]

{ #category : #accessing }
DMClassNamesblueprint >> orderBySize [
	orderBySize := true
]

{ #category : #accessing }
DMClassNamesblueprint >> show [
	^DMRoassalClassNamesBlueprint visualize: viewModel 
]

{ #category : #'as yet unclassified' }
DMClassNamesblueprint >> startBuilding [
	| thePackageModels |
	thePackageModels := (DMBuilder doPackageModelsOf: self viewModel).
	self viewModel 
		name: self model name;
		packageModels: thePackageModels;
		motherRoot: self motherRoot;
		model: self model;
		rootModels: (DMBuilder buildRootsOf: (thePackageModels flatCollect: #classModels) Accordingto: self motherRoot).
	
]

{ #category : #accessing }
DMClassNamesblueprint >> viewModel [
	^viewModel 
]

{ #category : #accessing }
DMClassNamesblueprint >> viewModel: aViewModel [
	viewModel := aViewModel 
]
