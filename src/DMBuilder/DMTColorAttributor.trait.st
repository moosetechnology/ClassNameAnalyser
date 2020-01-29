Trait {
	#name : #DMTColorAttributor,
	#instVars : [
		'viewModel'
	],
	#category : #DMBuilder
}

{ #category : #accessing }
DMTColorAttributor >> color: aViewModel [

	viewModel := aViewModel.
	self colorConceptViewModels.

]

{ #category : #'as yet unclassified' }
DMTColorAttributor >> colorClassViewModels [

	viewModel packageViewModels collect: [ :packageVM | packageVM conceptViewModels 
		collect: [ :conceptVM | conceptVM classViewModels collect: 
			[ :classVM | classVM color: (self selectColorFor: classVM concept) ]
			]
		 ]
]

{ #category : #'as yet unclassified' }
DMTColorAttributor >> colorConceptViewModels [
	
		viewModel packageViewModels collect: [ :packageVM |  packageVM conceptViewModels collect: [ :conceptVM | conceptVM root: (self selectBiggestHierarchyFor: conceptVM name); color: (self selectColorFor: conceptVM name) ]  ].
	self colorClassViewModels.
]

{ #category : #actions }
DMTColorAttributor >> selectBiggestHierarchyFor: aConcept [

	| biggest rootModels index |
	index := 2.
	rootModels := viewModel rootmodels select: [ :each | (each concepts includes: aConcept) ].
	(rootModels isNotEmpty) ifTrue:[ biggest := rootModels at: 1].
	(rootModels size == 1)
	ifTrue: [ ^biggest ].
	
	[index <= rootModels size] whileTrue: [ rootModels do: [ :aRootModel | ((aRootModel subclasses size) > (biggest subclasses size))
		ifTrue: [ biggest := aRootModel ].
		index := index +1.
		 ]].
	^biggest
	

]

{ #category : #preferences }
DMTColorAttributor >> selectColorFor: aConcept [

	| rootmodel |
	rootmodel := self selectBiggestHierarchyFor: aConcept.
	^rootmodel color
]

{ #category : #'as yet unclassified' }
DMTColorAttributor >> selectRootOf: aClassVM [

	^viewModel rootmodels select: [ :aRootModel | aRootModel subclasses includes: aClassVM ]
]

{ #category : #accessing }
DMTColorAttributor >> viewModel [
	^viewModel
]

{ #category : #accessing }
DMTColorAttributor >> viewModel: aViewModel [

	^viewModel
]
