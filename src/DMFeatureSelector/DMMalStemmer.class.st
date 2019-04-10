Class {
	#name : #DMMalStemmer,
	#superclass : #Object,
	#instVars : [
		'cache'
	],
	#classVars : [
		'English'
	],
	#category : #DMFeatureSelector
}

{ #category : #stemming }
DMMalStemmer class >> English [

	^ English ifNil: [English := MalPorterStemmer new].
]

{ #category : #stemming }
DMMalStemmer class >> stemming: aString [
	
	^self English stemming: aString
]

{ #category : #'private-algorithm' }
DMMalStemmer >> cache [
	"Answer the cache of stemmed words."
	
	^cache isNil
		ifTrue: [cache := Dictionary new]
		ifFalse: [cache]
]

{ #category : #'private-algorithm' }
DMMalStemmer >> performStemming: aString [
	"Perform the stemming of a string."
	
	^self subclassResponsibility
]

{ #category : #accessing }
DMMalStemmer >> purgeCache [
	"Clear the recievers cache of stemmed words."
	
	cache := nil
]

{ #category : #accessing }
DMMalStemmer >> stemming: aString [
	"Answer the the morphological root of a word, ie removes its suffix."
	
	^self cache
		at: aString
		ifAbsentPut: [self performStemming: aString]
]
