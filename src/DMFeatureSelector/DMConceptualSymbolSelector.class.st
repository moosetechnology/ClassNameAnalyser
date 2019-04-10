Class {
	#name : #DMConceptualSymbolSelector,
	#superclass : #Object,
	#category : #DMFeatureSelector
}

{ #category : #actions }
DMConceptualSymbolSelector >> selectFirstSymbolFrom: aCollection [
	^ aCollection first.
]

{ #category : #actions }
DMConceptualSymbolSelector >> selectLastSymbolFrom: aCollection [
	^ aCollection last.
]

{ #category : #actions }
DMConceptualSymbolSelector >> selectMiddleSymbolFrom: aCollection [
	^ aCollection middle.
]
