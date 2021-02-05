Class {
	#name : #DMClassNamesBlueprintSample,
	#superclass : #Object,
	#category : #DMClassNamesBlueprintSamples
}

{ #category : #'as yet unclassified' }
DMClassNamesBlueprintSample class >> importProject: aPath [

	^(MooseModelSample importProject: aPath) defaultClassNamesBlueprint 
]

{ #category : #'as yet unclassified' }
DMClassNamesBlueprintSample class >> projectNameMatches: aString [ 

	^(MooseModelSample projectNameMatches: aString) defaultClassNamesBlueprint 
]
