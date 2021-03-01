Class {
	#name : #CNBMalStemmer,
	#superclass : #Object,
	#instVars : [
		'cache'
	],
	#classVars : [
		'English'
	],
	#category : #CNBFeatureSelector
}

{ #category : #stemming }
CNBMalStemmer class >> English [

	^ English ifNil: [English := CNBMalAbstractStemmer new].
]

{ #category : #stemming }
CNBMalStemmer class >> stemming: aString [
	
	^self English stemming: aString
]

{ #category : #'private-algorithm' }
CNBMalStemmer >> cache [
	"Answer the cache of stemmed words."
	
	^cache isNil
		ifTrue: [cache := Dictionary new]
		ifFalse: [cache]
]

{ #category : #accessing }
CNBMalStemmer >> purgeCache [
	"Clear the recievers cache of stemmed words."
	
	cache := nil
]

{ #category : #accessing }
CNBMalStemmer >> stemming: aString [
	"Answer the the morphological root of a word, ie removes its suffix."
	
	^self cache
		at: aString
		ifAbsentPut: [self performStemming: aString]
]
