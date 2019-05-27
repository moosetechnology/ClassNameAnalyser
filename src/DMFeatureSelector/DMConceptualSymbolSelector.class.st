Class {
	#name : #DMConceptualSymbolSelector,
	#superclass : #Object,
	#category : #DMFeatureSelector
}

{ #category : #setter }
DMConceptualSymbolSelector >> selectFirstSymbol: aClassName [
]

{ #category : #actions }
DMConceptualSymbolSelector >> selectFirstSymbolFrom: aCollection [
	^ aCollection first.
]

{ #category : #setter }
DMConceptualSymbolSelector >> selectLastSymbol: aClassName [

	| nameTokenizer collectionOfSymbols |
	nameTokenizer := DMNameTokenizer new.
	collectionOfSymbols := nameTokenizer tokenize: aClassName asString .
	^ self selectLastSymbolFrom: collectionOfSymbols 
]

{ #category : #actions }
DMConceptualSymbolSelector >> selectLastSymbolFrom: aCollection [
	^ aCollection last.
]

{ #category : #actions }
DMConceptualSymbolSelector >> selectMiddleSymbolFrom: aCollection [
	^ aCollection middle.
]
