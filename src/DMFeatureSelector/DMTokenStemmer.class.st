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

{ #category : #'as yet unclassified' }
DMTokenStemmer >> stemToken: aToken [
	^ internalStemmer stem: aToken 

]

{ #category : #'as yet unclassified' }
DMTokenStemmer >> stemTokens: aCollectionOfTokens [
	^ aCollectionOfTokens collect: [ :each | internalStemmer stem: each ]
]
