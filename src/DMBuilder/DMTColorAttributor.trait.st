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
