Class {
	#name : #DMSizeAttributor,
	#superclass : #Object,
	#category : #DMClassNameBlueprint
}

{ #category : #initialization }
DMSizeAttributor >> attributeSize: aViewModel [

	| viewModel allPackageViewModels allConceptViewModels |
	viewModel := DMViewModel new.
	viewModel := aViewModel.
	viewModel size: (viewModel packageViewModels size).
	viewModel packageViewModels do: [ :aPackageViewModel |
		aPackageViewModel size: (aPackageViewModel conceptViewModels size).
		 ].
	allPackageViewModels := viewModel packageViewModels.
	allConceptViewModels := allPackageViewModels flatCollect: [ :aPackageViewModel | 
		aPackageViewModel conceptViewModels.
		 ].
		allConceptViewModels do: [ :aConceptViewModel |
		aConceptViewModel size: (aConceptViewModel classViewModels size).
		 ].
	^ viewModel 
	
]
