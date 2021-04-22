Class {
	#name : #CNBClassNamesBlueprintGenerator,
	#superclass : #Object,
	#category : #CNBProjectImporter
}

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> importProject: aPath [

	^ ClassNamesBlueprint new
		model: (CNBModelGenerator importProject: aPath)
]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> packagesNamed: aCollection [ 

	^ ClassNamesBlueprint new
		model: (CNBModelGenerator packagesNamed: aCollection) 
]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> projectNameMatches: aString [ 

	^ ClassNamesBlueprint new
		model: (CNBModelGenerator projectNameMatches: aString) 
]
