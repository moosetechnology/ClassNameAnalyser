Class {
	#name : #CNBFeatureSelector,
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
CNBFeatureSelector class >> extractSuffixFrom: aString [
	^self new
		extractSuffixFrom: aString
]

{ #category : #'as yet unclassified' }
CNBFeatureSelector >> extract: tokenPosition from: aName [
	^ (tokenPosition = #prefix)
		ifTrue: [ self extractPrefixFrom: aName ]
		ifFalse: [ self extractSuffixFrom: aName ]
]

{ #category : #actions }
CNBFeatureSelector >> extractClassNamesFrom: aPackageName [
	^ ((RPackageOrganizer default packageNamed: aPackageName)  definedClasses collect: [ :each | each instanceSide name ]).
]

{ #category : #actions }
CNBFeatureSelector >> extractClassesFrom: aPackageName [

	^ ((RPackageOrganizer default packageNamed: aPackageName)  
			definedClasses collect: [ :each | each  ]) asOrderedCollection
]

{ #category : #actions }
CNBFeatureSelector >> extractPrefixFrom: aName [

	| aConcept tokens|
	tokens := self tokenize: aName.
	aConcept := self selectPrefixFrom: tokens.
	aConcept := filterer removeAllDigitsFrom: aConcept.
	aConcept := self stem: aConcept.
	^ aConcept
]

{ #category : #actions }
CNBFeatureSelector >> extractRootClassFrom: aClass [

	({ Object . ProtoObject } includes: aClass)
		ifTrue: [ ^ aClass ].
		
	aClass isTrait
		ifTrue: [ ^ aClass ].

	(aClass superclass == Object)
		ifTrue: [ ^ aClass  ].
	
	^ self extractRootClassFrom: (aClass superclass).
]

{ #category : #actions }
CNBFeatureSelector >> extractSuffixFrom: aName [

	| aConcept tokens|
	tokens := self tokenize: aName.
	aConcept := self selectSuffixFrom: tokens.
	aConcept := filterer removeAllDigitsFrom: aConcept.
	aConcept := self stem: aConcept.
	^ aConcept
]

{ #category : #actions }
CNBFeatureSelector >> filter: aConcept [

	| symbol |
	symbol := aConcept.
	(filtererAllDigits) 
		ifTrue: [ symbol := filterer removeAllDigitsFrom: aConcept ].	
	(filterSpecialChars)
		ifTrue: [ symbol := filterer removeAllSpecialCharsFrom: symbol  ] .
	^ symbol

]

{ #category : #setter }
CNBFeatureSelector >> filterAllDigits: aBoolean [
	 filtererAllDigits := aBoolean
]

{ #category : #setter }
CNBFeatureSelector >> filterAllDigitsAndSpecialChars: aBoolean [

	self filterAllDigits: aBoolean.
	self filterSpecialChars: aBoolean
]

{ #category : #setter }
CNBFeatureSelector >> filterSpecialChars: aBoolean [
	 filterSpecialChars := aBoolean 
]

{ #category : #initialization }
CNBFeatureSelector >> initialize [ 

	super initialize.
	nameTokenizer := CNBNameTokenizer new.
	tokenStemmer := CNBTokenStemmer new.
	conceptualSymbolSelector := CNBConceptualSymbolSelector new.
	filterer := CNBFilterer new.
	stemming := false.
	filtererAllDigits := false.
	filterSpecialChars := false.
]

{ #category : #actions }
CNBFeatureSelector >> selectPrefixFrom: tokens [

 ^ conceptualSymbolSelector selectFirstSymbolFrom: tokens 
]

{ #category : #actions }
CNBFeatureSelector >> selectSuffixFrom: tokens [

 ^ conceptualSymbolSelector selectLastSymbolFrom: tokens 
]

{ #category : #actions }
CNBFeatureSelector >> stem: aConcept [

	(stemming) 
		ifTrue: [ ^tokenStemmer stemToken: aConcept ]
		ifFalse: [ ^ aConcept ]
]

{ #category : #setter }
CNBFeatureSelector >> stemming: aBoolean [

	(aBoolean) 
		ifTrue: [ stemming := true ]
]

{ #category : #actions }
CNBFeatureSelector >> tokenize: aName [
	^ nameTokenizer tokenize: aName
]
