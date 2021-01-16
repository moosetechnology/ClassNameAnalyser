Trait {
	#name : #DMTColorAttributor,
	#instVars : [
		'viewModel'
	],
	#category : #DMBuilder
}

{ #category : #coloring }
DMTColorAttributor >> attributeColorByType: aType [

	(aType = #Trait)
	ifTrue: [ ^ #white ].
	
	(aType = #monoClass)
	ifTrue: [ ^ #white ].
	
	(aType = #monoSuffix)
	ifTrue: [ ^#gray ].
	
	(aType = #multiSuffix)
	ifTrue: [ ^self aColorFromPalette ].
]

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
	
	^(self selectBiggestHierarchyFor: aConcept) first color
]
