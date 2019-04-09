Class {
	#name : #DMNameTokenizer,
	#superclass : #Object,
	#instVars : [
		'name',
		'tokens'
	],
	#category : #DMFeatureSelector
}

{ #category : #'as yet unclassified' }
DMNameTokenizer >> checkCapitalLetter: aCharacter [
	
	(((aCharacter asciiValue) > 64) and: [ ((aCharacter asciiValue) < 91) ] ) 
		ifTrue: [ ^ true ] 
		ifFalse: [ ^ false ]
]

{ #category : #'as yet unclassified' }
DMNameTokenizer >> checkSpecialChar: aCharacter [

	| arrayOfNonAlphaNumerics |
	arrayOfNonAlphaNumerics := #('#' '''' '.' '"' '@' '-' '_' '$' '£' '°' '!' '?' '&' '²' '^' '[' ']' '(' 	')' '%' '/' '`' '{' '}' ':' ';' '=' '*' '+').
	(arrayOfNonAlphaNumerics includes: (aCharacter))
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #'as yet unclassified' }
DMNameTokenizer >> cutWhereCamelCase: aName [
	"This method is implemented in String"
	
	self name: aName.
	^ self name cutWhereCamelCase.
]

{ #category : #accessing }
DMNameTokenizer >> name [
	^ name
]

{ #category : #accessing }
DMNameTokenizer >> name: aName [
	name := aName
]

{ #category : #accessing }
DMNameTokenizer >> tokens [
	^ tokens
]
