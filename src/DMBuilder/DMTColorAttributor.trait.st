Trait {
	#name : #DMTColorAttributor,
	#instVars : [
		'viewModel'
	],
	#category : #DMBuilder
}

{ #category : #accessing }
DMTColorAttributor >> color: rootModels [
	| sortedRootModels coloredRootModels |
	sortedRootModels := self sortRootModels: rootModels.
	coloredRootModels := (sortedRootModels 
		collect: 
			[ :eachRootModel | eachRootModel color: (self attributeColorByType: eachRootModel type) ]).
	self class rootmodels: coloredRootModels.
	^coloredRootModels 
	
]

{ #category : #preferences }
DMTColorAttributor >> selectColorFor: aConcept [
	
	^(self selectBiggestHierarchyFor: aConcept) color
]
