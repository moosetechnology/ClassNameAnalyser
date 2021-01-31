Trait {
	#name : #DMTBuilder,
	#traits : 'DMTColorAttributor',
	#classTraits : 'DMTColorAttributor classTrait',
	#category : #DMBuilder
}

{ #category : #'as yet unclassified' }
DMTBuilder >> attributeColorByType: aType [

	(aType = #Trait)
	ifTrue: [ ^ #white ].
	
	(aType = #monoClass)
	ifTrue: [ ^ #white ].
	
	(aType = #monoSuffix)
	ifTrue: [ ^#gray ].
	
	(aType = #multiSuffix)
	ifTrue: [ ^self aColorForMultiSuffix ].
]
