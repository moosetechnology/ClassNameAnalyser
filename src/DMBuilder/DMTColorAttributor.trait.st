Trait {
	#name : #DMTColorAttributor,
	#instVars : [
		'viewModel'
	],
	#category : #DMBuilder
}

{ #category : #preferences }
DMTColorAttributor >> selectColorFor: aConcept [

	^(self selectBiggestHierarchyFor: aConcept) color
]

{ #category : #'as yet unclassified' }
DMTColorAttributor >> selectRootOf: aClassVM [

	^viewModel rootmodels select: [ :aRootModel | aRootModel subclasses includes: aClassVM ]
]
