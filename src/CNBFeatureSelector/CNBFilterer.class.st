Class {
	#name : #CNBFilterer,
	#superclass : #Object,
	#category : #CNBFeatureSelector
}

{ #category : #removing }
CNBFilterer class >> removeAllDigitsAndSpecialCharsFrom: aName [
	^ self new
		removeAllDigitsAndSpecialCharsFrom: aName
]

{ #category : #filtering }
CNBFilterer >> removeAllDigitsAndSpecialCharsFrom: aName [

	| tokens |
	tokens := self removeAllDigitsFrom: aName.
	tokens := self removeAllSpecialCharsFrom: tokens.
	^ tokens
]

{ #category : #filtering }
CNBFilterer >> removeAllDigitsFrom: aName [

	| tokens token |
	token := ''.
	tokens := aName piecesCutWhereCamelCase.
	tokens := tokens reject: [ :each | each isAllDigits ].
	tokens do: [ :each | token := token , each ]. 	
	^ token
]

{ #category : #filtering }
CNBFilterer >> removeAllSpecialCharsFrom: aName [

	| tokenizer token tokens|
	token := ''.
	tokenizer := CNBNameTokenizer new.
	tokens := aName piecesCutWhereNonAlphaNumeric.
	tokens := tokens reject: [ :each | each asString isAllAlphaNumerics not ].
	tokens do: [ :each | token := token , each asString ].	
	^ token
]
