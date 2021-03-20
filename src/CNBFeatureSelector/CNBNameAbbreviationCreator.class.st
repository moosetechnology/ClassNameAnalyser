Class {
	#name : #CNBNameAbbreviationCreator,
	#superclass : #Object,
	#category : #CNBFeatureSelector
}

{ #category : #'as yet unclassified' }
CNBNameAbbreviationCreator class >> abbreviate: aName until: aNumber [ 

	 ^self new 
	abbreviate: aName
	until: aNumber
]

{ #category : #splitjoin }
CNBNameAbbreviationCreator >> abbreviate: aName until: aNumber [

	| tokens nameParts abbreviations |
	tokens := CNBNameTokenizer tokenize: aName.
	nameParts := tokens size > aNumber
		             ifTrue: [ self devide: tokens until: aNumber ]
		             ifFalse: [ self devide: tokens until: tokens size - 1 ].
	abbreviations := nameParts first collect: [ :aCaracter | 
		                 aCaracter first asUppercase ].

	^ abbreviations concatenatesStrings
	  , nameParts second concatenatesStrings
]

{ #category : #splitjoin }
CNBNameAbbreviationCreator >> devide: aCollection until: aNumber [
	| firstPartTokens secondPartTokens |
	aCollection size > aNumber
		ifTrue: [ firstPartTokens := aCollection copyFrom: 1 to: aNumber.
			secondPartTokens := aCollection asOrderedCollection
				removeAllFoundIn: firstPartTokens;
				yourself.
			^ Array with: firstPartTokens with: secondPartTokens asArray ].
	^ aCollection
]
