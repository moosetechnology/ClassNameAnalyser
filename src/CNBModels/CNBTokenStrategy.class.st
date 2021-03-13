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
CNBTokenStrategy >> build: aViewModel [

	| thePackageModels |
	thePackageModels := CNBBuilder doPackageModelsOf: aViewModel.
	aViewModel 
		name: aViewModel model name;
		packageModels: thePackageModels;
		rootModels: (CNBBuilder doRootsOf: (thePackageModels flatCollect: #classModels)).
	
		aViewModel packageViewModels: (CNBBuilder doPackageViewModelsOf: aViewModel).
		aViewModel attributeTokenModelsToRoots.
		aViewModel attributePatterns.
		^ aViewModel 

]
