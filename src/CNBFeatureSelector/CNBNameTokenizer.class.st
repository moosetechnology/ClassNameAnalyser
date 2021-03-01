Class {
	#name : #CNBNameTokenizer,
	#superclass : #Object,
	#category : #CNBFeatureSelector
}

{ #category : #parsing }
CNBNameTokenizer class >> tokenize: aName [ 
	^self new tokenize: aName 
]

{ #category : #tokenizing }
CNBNameTokenizer >> tokenize: aName [
	| word token allTokens resultedTokens|
	word := aName deepCopy.
	token := ''.
	allTokens := OrderedCollection new.
	resultedTokens := OrderedCollection new.
	1 to: word size do: [ :index | 	((word at: index) isUppercase) 
		ifTrue: [ 
			allTokens add: token.
			token := (word at: index) asString.
			 ] 
		ifFalse: [ token := token , (word at: index) asString  ].
		(index == word size) 
		ifTrue: [ allTokens add: token ]
		].
	token := ''.
	allTokens do:  [ :each | (each size == 1)
		ifTrue: [ token := token , each asString ]
		ifFalse: [ resultedTokens add: token. 
			token := ''.
			resultedTokens add: each ]
		 ].
	resultedTokens add: token.
	^ resultedTokens reject: [ :each | each size ==0 ]

]
