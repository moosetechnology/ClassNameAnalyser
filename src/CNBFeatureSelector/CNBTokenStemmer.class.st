Class {
	#name : #CNBTokenStemmer,
	#superclass : #Object,
	#instVars : [
		'internalStemmer'
	],
	#category : #CNBFeatureSelector
}

{ #category : #initialization }
CNBTokenStemmer >> initialize [ 

	super initialize.
	internalStemmer := CNBStemmer new.
]

{ #category : #stemming }
CNBTokenStemmer >> stemToken: aToken [
	^ internalStemmer stemming: aToken 

]

{ #category : #stemming }
CNBTokenStemmer >> stemTokens: aCollectionOfTokens [
	^ aCollectionOfTokens collect: [ :each | internalStemmer stemming: each ]
]
