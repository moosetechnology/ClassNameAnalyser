Class {
	#name : #CNBTokenStrategy,
	#superclass : #Object,
	#category : #CNBModels
}

{ #category : #building }
CNBTokenStrategy class >> build: aViewModel [
	^ self new
			build: aViewModel 
]

{ #category : #building }
CNBTokenStrategy >> build: aCND [

	| thePackageModels |
	thePackageModels := CNBBuilder doPackageModelsOf: aCND.
	aCND viewModel
		name: aCND model name;
		packageModels: thePackageModels;
		rootModels: (CNBBuilder doRootsOf: (thePackageModels flatCollect: #classModels)).
	
		aCND viewModel packageViewModels: (CNBBuilder doPackageViewModelsOf: aCND).
		aCND viewModel attributeTokenModelsToRoots.
		aCND viewModel attributePatterns.
		^ aCND 

]
