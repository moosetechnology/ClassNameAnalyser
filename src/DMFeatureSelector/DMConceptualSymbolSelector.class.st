Class {
	#name : #DMConceptualSymbolSelector,
	#superclass : #Object,
	#instVars : [
		'tokenStemmer',
		'nameTokenizer',
		'token',
		'name',
		'tokens',
		'concepts'
	],
	#category : #DMFeatureSelector
}

{ #category : #initialization }
DMConceptualSymbolSelector >> initialize [ 

	super initialize.
	tokenStemmer := DMTokenStemmer new.
	nameTokenizer := DMNameTokenizer new.
]

{ #category : #accessing }
DMConceptualSymbolSelector >> nameTokenizer [
	^ nameTokenizer
]

{ #category : #'as yet unclassified' }
DMConceptualSymbolSelector >> selectFirstSymbolFrom: aCollection [
	^ aCollection first.
]

{ #category : #'as yet unclassified' }
DMConceptualSymbolSelector >> selectLastSymbolFrom: aCollection [
	^ aCollection last.
]

{ #category : #'as yet unclassified' }
DMConceptualSymbolSelector >> selectMiddleSymbolFrom: aCollection [
	^ aCollection middle.
]

{ #category : #accessing }
DMConceptualSymbolSelector >> token [
	^ token
]

{ #category : #accessing }
DMConceptualSymbolSelector >> tokenStemmer [
	^ tokenStemmer
]
