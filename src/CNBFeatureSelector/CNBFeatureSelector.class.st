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

{ #category : #extraction }
CNBFeatureSelector class >> extractPrefixFrom: aName [

	^ self new
			extractPrefixFrom: aName
]

{ #category : #actions }
CNBFeatureSelector class >> extractSuffixFrom: aString [
	^self new
		extractSuffixFrom: aString
]

{ #category : #extraction }
CNBFeatureSelector >> extract: tokenPosition from: aName [

	^ (tokenPosition = #prefix)
		ifTrue: [ self extractPrefixFrom: aName ]
		ifFalse: [ self extractSuffixFrom: aName
			 ]
]

{ #category : #extraction }
CNBFeatureSelector >> extractClassNamesFrom: aPackageName [
	^ ((RPackageOrganizer default packageNamed: aPackageName)  definedClasses collect: [ :each | each instanceSide name ]).
]

{ #category : #extraction }
CNBFeatureSelector >> extractClassesFrom: aPackageName [

	^ ((RPackageOrganizer default packageNamed: aPackageName)  
			definedClasses collect: [ :each | each  ]) asOrderedCollection
]

{ #category : #extraction }
CNBFeatureSelector >> extractPrefixFrom: aName [

   | newName tokens prefix |
	
	newName := filterer removeAllDigitsAndSpecialCharsFrom: aName.
	tokens := self tokenize: newName.
	prefix := self selectPrefixFrom: tokens.
	"prefix := tokens detect: [ :each | each size > 2 ] ifNone: [ self selectPrefixFrom: tokens ]."
	prefix := self stem: prefix.
	^ prefix 
]

{ #category : #extraction }
CNBFeatureSelector >> extractRootClassFrom: aClass [

	({ Object . ProtoObject } includes: aClass)
		ifTrue: [ ^ aClass ].
		
	aClass isTrait
		ifTrue: [ ^ aClass ].

	(aClass superclass == Object)
		ifTrue: [ ^ aClass  ].
	
	^ self extractRootClassFrom: (aClass superclass).
]

{ #category : #extraction }
CNBFeatureSelector >> extractSuffixFrom: aName [

	| newName tokens suffix |
	
	newName := filterer removeAllDigitsAndSpecialCharsFrom: aName.
	tokens := self tokenize: newName.
	suffix := self selectSuffixFrom: tokens.
	suffix := self stem: suffix.
	^ suffix 
]

{ #category : #filtering }
CNBFeatureSelector >> filter: aConcept [

	| symbol |
	symbol := aConcept.
	(filtererAllDigits) 
		ifTrue: [ symbol := filterer removeAllDigitsFrom: aConcept ].	
	(filterSpecialChars)
		ifTrue: [ symbol := filterer removeAllSpecialCharsFrom: symbol  ] .
	^ symbol

]

{ #category : #filtering }
CNBFeatureSelector >> filterAll: aCollectionOfTokens [

	^ aCollectionOfTokens collect: [ :each | filterer removeAllDigitsAndSpecialCharsFrom: each ]

]

{ #category : #filtering }
CNBFeatureSelector >> filterAllDigits: aBoolean [
	 filtererAllDigits := aBoolean
]

{ #category : #filtering }
CNBFeatureSelector >> filterAllDigitsAndSpecialChars: aBoolean [

	self filterAllDigits: aBoolean.
	self filterSpecialChars: aBoolean
]

{ #category : #filtering }
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
	filtererAllDigits := true.
	filterSpecialChars := true.
]

{ #category : #removing }
CNBFeatureSelector >> removeAllDigitsAndSpecialCharsFrom: aName [

	^ filterer removeAllDigitsAndSpecialCharsFrom: aName 
]

{ #category : #selection }
CNBFeatureSelector >> selectPrefixFrom: tokens [

 ^ conceptualSymbolSelector selectFirstSymbolFrom: tokens 
]

{ #category : #selection }
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
