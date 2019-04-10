Class {
	#name : #DMNameTokenizer,
	#superclass : #Object,
	#category : #DMFeatureSelector
}

{ #category : #checking }
DMNameTokenizer >> checkCapitalLetter: aCharacter [
	
	(((aCharacter asciiValue) > 64) and: [ ((aCharacter asciiValue) < 91) ] ) 
		ifTrue: [ ^ true ] 
		ifFalse: [ ^ false ]
]

{ #category : #checking }
DMNameTokenizer >> checkSpecialChar: aCharacter [

	| arrayOfNonAlphaNumerics |
	arrayOfNonAlphaNumerics := #('#' '''' '.' '"' '@' '-' '_' '$' '£' '°' '!' '?' '&' '²' '^' '[' ']' '(' 	')' '%' '/' '`' '{' '}' ':' ';' '=' '*' '+').
	(arrayOfNonAlphaNumerics includes: (aCharacter))
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #tokenizing }
DMNameTokenizer >> cutWhereCamelCase: aName [
	"This method is implemented in String"
	
	| name |
	name := aName.
	^ name cutWhereCamelCase.
]
