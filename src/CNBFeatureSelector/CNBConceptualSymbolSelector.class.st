Class {
	#name : #CNBConceptualSymbolSelector,
	#superclass : #Object,
	#category : #CNBFeatureSelector
}

{ #category : #setter }
CNBConceptualSymbolSelector >> selectFirstSymbol: aClassName [
]

{ #category : #actions }
CNBConceptualSymbolSelector >> selectFirstSymbolFrom: aCollection [
	^ aCollection first.
]

{ #category : #setter }
CNBConceptualSymbolSelector >> selectLastSymbol: aClassName [

	| nameTokenizer collectionOfSymbols |
	nameTokenizer := CNBNameTokenizer new.
	collectionOfSymbols := nameTokenizer tokenize: aClassName asString .
	^ self selectLastSymbolFrom: collectionOfSymbols 
]

{ #category : #actions }
CNBConceptualSymbolSelector >> selectLastSymbolFrom: aCollection [
	^ aCollection last.
]

{ #category : #actions }
CNBConceptualSymbolSelector >> selectMiddleSymbolFrom: aCollection [
	^ aCollection middle.
]
