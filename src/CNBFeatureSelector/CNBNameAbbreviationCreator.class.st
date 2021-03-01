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
	| tokens collections abbreviations |
	tokens := CNBNameTokenizer tokenize: aName.
	tokens size > aNumber
		ifTrue: [ collections := self devide: tokens until: aNumber .
	abbreviations := collections first
		collect: [ :token1 | token1 first asUppercase ].
	^ abbreviations concatenatesStrings
		, collections last concatenatesStrings].	
	^aName
]

{ #category : #splitjoin }
CNBNameAbbreviationCreator >> devide: aCollection until: aNumber [
	| collection1 collection2 |
	aCollection size > aNumber
		ifTrue: [ collection1 := aCollection copyFrom: 1 to: aNumber.
			collection2 := aCollection asOrderedCollection
				removeAllFoundIn: collection1;
				yourself.
			^ Array with: collection1 with: collection2 asArray ].
	^ aCollection
]
