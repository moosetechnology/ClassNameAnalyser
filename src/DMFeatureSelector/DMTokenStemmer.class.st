Class {
	#name : #DMTokenStemmer,
	#superclass : #Object,
	#instVars : [
		'internalStemmer'
	],
	#category : #DMFeatureSelector
}

{ #category : #initialization }
DMTokenStemmer >> initialize [ 

	super initialize.
	internalStemmer := MalPorterStemmer new.
]

{ #category : #stemming }
DMTokenStemmer >> stemToken: aToken [
	^ internalStemmer stemming: aToken 

]

{ #category : #stemming }
DMTokenStemmer >> stemTokens: aCollectionOfTokens [
	^ aCollectionOfTokens collect: [ :each | internalStemmer stemming: each ]
]
