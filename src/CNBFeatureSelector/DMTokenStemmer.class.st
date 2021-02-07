Class {
	#name : #DMTokenStemmer,
	#superclass : #Object,
	#instVars : [
		'internalStemmer'
	],
	#category : #CNBFeatureSelector
}

{ #category : #initialization }
DMTokenStemmer >> initialize [ 

	super initialize.
	internalStemmer := DMStemmer new.
]

{ #category : #stemming }
DMTokenStemmer >> stemToken: aToken [
	^ internalStemmer stemming: aToken 

]

{ #category : #stemming }
DMTokenStemmer >> stemTokens: aCollectionOfTokens [
	^ aCollectionOfTokens collect: [ :each | internalStemmer stemming: each ]
]
