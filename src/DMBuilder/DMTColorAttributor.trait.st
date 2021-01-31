Trait {
	#name : #DMTColorAttributor,
	#instVars : [
		'viewModel'
	],
	#category : #DMBuilder
}

{ #category : #'as yet unclassified' }
DMTColorAttributor >> attributeColorByType: aType [

	(aType = #Trait)
	ifTrue: [ ^ #white ].
	
	(aType = #monoClass)
	ifTrue: [ ^ #white ].
	
	(aType = #monoSuffix)
	ifTrue: [ ^#gray ].
	
	(aType = #multiSuffix)
	ifTrue: [ ^self aColorForMultiSuffix ].
]

{ #category : #'as yet unclassified' }
DMTColorAttributor >> color: rootModels [
	| sortedRootModels coloredRootModels |
	sortedRootModels := self sortRootModels: rootModels.
	coloredRootModels := (sortedRootModels 
		collect: 
			[ :eachRootModel | eachRootModel color: (self attributeColorByType: eachRootModel type) ]).
	^coloredRootModels 
	
]

{ #category : #initialization }
DMTColorAttributor >> defaultColor [ 
	^#black
]
