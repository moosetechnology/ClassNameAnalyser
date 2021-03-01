Class {
	#name : #CNBClassNamesBlueprintGenerator,
	#superclass : #Object,
	#category : #CNBProjectImporter
}

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> importProject: aPath [

	^(CNBMooseModelGenerator importProject: aPath) defaultClassNamesBlueprint 
]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> projectNameMatches: aString [ 

	^(CNBMooseModelGenerator projectNameMatches: aString) defaultClassNamesBlueprint 
]
