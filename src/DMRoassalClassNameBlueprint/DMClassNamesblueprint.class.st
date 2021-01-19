Class {
	#name : #DMClassNamesblueprint,
	#superclass : #Object,
	#instVars : [
		'viewModel',
		'roassalView'
	],
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #initialization }
DMClassNamesblueprint >> initialize [
	super initialize.
	viewModel := DMViewModel new.
	roassalView := DMRoassalClassNamesBlueprint new
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
	roassalView orderByColor 
]

{ #category : #accessing }
DMClassNamesblueprint >> orderBySize [
	roassalView orderBySize 
]

{ #category : #accessing }
DMClassNamesblueprint >> rootModels [ 
	^viewModel rootModels
]

{ #category : #accessing }
DMClassNamesblueprint >> show [
	^roassalView visualize: viewModel 
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
		rootModels: (DMBuilder buildRootsOf: (thePackageModels flatCollect: #classModels) Accordingto: 		self motherRoot);
		packageViewModels: (DMBuilder doPackageViewModelsOf: self viewModel).
	 
]

{ #category : #accessing }
DMClassNamesblueprint >> viewModel [
	^viewModel 
]

{ #category : #accessing }
DMClassNamesblueprint >> viewModel: aViewModel [
	viewModel := aViewModel 
]
