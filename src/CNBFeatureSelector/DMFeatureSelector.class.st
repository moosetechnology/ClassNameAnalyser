Class {
	#name : #DMFeatureSelector,
	#superclass : #Object,
	#instVars : [
		'filtererAllDigits',
		'filterer',
		'filterSpecialChars',
		'nameTokenizer',
		'tokenStemmer',
		'conceptualSymbolSelector',
		'stemming',
		'selectLastSymbol',
		'selectMiddleSymbol',
		'selectFirstSymbol'
	],
	#category : #CNBFeatureSelector
}

{ #category : #actions }
DMFeatureSelector class >> extractSuffixFrom: aString [
	^self new
		extractSuffixFrom: aString
]

{ #category : #actions }
DMFeatureSelector >> extractClassNamesFrom: aPackageName [
	^ ((RPackageOrganizer default packageNamed: aPackageName)  definedClasses collect: [ :each | each instanceSide name ]).
]

{ #category : #actions }
DMFeatureSelector >> extractClassesFrom: aPackageName [

	^ ((RPackageOrganizer default packageNamed: aPackageName)  
			definedClasses collect: [ :each | each  ]) asOrderedCollection
]

{ #category : #actions }
DMFeatureSelector >> extractPrefixFrom: aName [

	| aConcept tokens|
	tokens := self tokenize: aName.
	aConcept := self selectPrefixFrom: tokens.
	aConcept := filterer removeAllDigitsFrom: aConcept.
	aConcept := self stem: aConcept.
	^ aConcept
]

{ #category : #actions }
DMFeatureSelector >> extractRootClassFrom: aClass [

	({ Object . ProtoObject } includes: aClass)
		ifTrue: [ ^ aClass ].
		
	aClass isTrait
		ifTrue: [ ^ aClass ].

	(aClass superclass == Object)
		ifTrue: [ ^ aClass  ].
	
	^ self extractRootClassFrom: (aClass superclass).
]

{ #category : #actions }
DMFeatureSelector >> extractSuffixFrom: aName [

	| aConcept tokens|
	tokens := self tokenize: aName.
	aConcept := self selectSuffixFrom: tokens.
	aConcept := filterer removeAllDigitsFrom: aConcept.
	aConcept := self stem: aConcept.
	^ aConcept
]

{ #category : #actions }
DMFeatureSelector >> filter: aConcept [

	| symbol |
	symbol := aConcept.
	(filtererAllDigits) 
		ifTrue: [ symbol := filterer removeAllDigitsFrom: aConcept ].	
	(filterSpecialChars)
		ifTrue: [ symbol := filterer removeAllSpecialCharsFrom: symbol  ] .
	^ symbol

]

{ #category : #setter }
DMFeatureSelector >> filterAllDigits: aBoolean [
	 filtererAllDigits := aBoolean
]

{ #category : #setter }
DMFeatureSelector >> filterAllDigitsAndSpecialChars: aBoolean [

	self filterAllDigits: aBoolean.
	self filterSpecialChars: aBoolean
]

{ #category : #setter }
DMFeatureSelector >> filterSpecialChars: aBoolean [
	 filterSpecialChars := aBoolean 
]

{ #category : #initialization }
DMFeatureSelector >> initialize [ 

	super initialize.
	nameTokenizer := DMNameTokenizer new.
	tokenStemmer := DMTokenStemmer new.
	conceptualSymbolSelector := DMConceptualSymbolSelector new.
	filterer := DMFilterer new.
	stemming := false.
	filtererAllDigits := false.
	filterSpecialChars := false.
]

{ #category : #actions }
DMFeatureSelector >> selectPrefixFrom: tokens [

 ^ conceptualSymbolSelector selectFirstSymbolFrom: tokens 
]

{ #category : #actions }
DMFeatureSelector >> selectSuffixFrom: tokens [

 ^ conceptualSymbolSelector selectLastSymbolFrom: tokens 
]

{ #category : #actions }
DMFeatureSelector >> stem: aConcept [

	(stemming) 
		ifTrue: [ ^tokenStemmer stemToken: aConcept ]
		ifFalse: [ ^ aConcept ]
]

{ #category : #setter }
DMFeatureSelector >> stemming: aBoolean [

	(aBoolean) 
		ifTrue: [ stemming := true ]
]

{ #category : #actions }
DMFeatureSelector >> tokenize: aName [
	^ nameTokenizer tokenize: aName
]
