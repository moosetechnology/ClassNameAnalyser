Class {
	#name : #DMFilterer,
	#superclass : #Object,
	#instVars : [
		'tokens'
	],
	#category : #DMFeatureSelector
}

{ #category : #removing }
DMFilterer >> removeAllDigitsAndSpecialCharsFrom: aName [

	tokens := self removeAllDigitsFrom: aName.
	tokens := self removeAllSpecialCharsFrom: tokens.
	^ tokens
]

{ #category : #removing }
DMFilterer >> removeAllDigitsFrom: aName [

	| token |
	token := ''.
	tokens := aName piecesCutWhereCamelCase.
	tokens := tokens reject: [ :each | each isAllDigits ].
	tokens do: [ :each | token := token , each .
	 ]. 	
	^ token
]

{ #category : #removing }
DMFilterer >> removeAllSpecialCharsFrom: aName [

	| tokenizer token |
	token := ''.
	tokenizer := DMNameTokenizer new.
	tokens := aName piecesCutWhereNonAlphaNumeric.
	tokens := tokens reject: [ :each | tokenizer checkSpecialChar: each ].
	tokens do: [ :each | token := token , each asString ].	
	^ token
]

{ #category : #accessing }
DMFilterer >> tokens [ 
	^ tokens
]
