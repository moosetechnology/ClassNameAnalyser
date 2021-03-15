Class {
	#name : #CNBClassNamesBlueprintGenerator,
	#superclass : #Object,
	#category : #CNBProjectImporter
}

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> importProject: aPath [

	^ ClassNamesBlueprint new
		model: (CNBMooseModelGenerator importProject: aPath)
]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> projectNameMatches: aString [ 

	^ ClassNamesBlueprint new
		model: (CNBMooseModelGenerator projectNameMatches: aString) 
]
