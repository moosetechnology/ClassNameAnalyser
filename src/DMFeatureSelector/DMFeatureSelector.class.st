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
	#category : #DMFeatureSelector
}

{ #category : #actions }
DMFeatureSelector class >> extractConceptFrom: aClass [ 
	^self new
		extractConceptFrom: aClass
]

{ #category : #actions }
DMFeatureSelector >> applyFeaturesOn: aCollectionOfPackageNames [

	| conceptualModel classes |
	conceptualModel := DMConceptualModel new.
	conceptualModel packageModels: (aCollectionOfPackageNames collect: [ :aPackageName |		| packageModel |
		packageModel := DMPackageModel new. 
		packageModel name: aPackageName.
		classes := self extractClassesFrom: aPackageName.
		packageModel classModels: (classes collect: [ :aClass | | classModel | 
			classModel := DMClassModel new.
			classModel name: aClass.
			classModel concept: (self extractConceptFrom: aClass name).
			classModel root: (self extractRootClassFrom: aClass).
			])  ]).
	^conceptualModel.
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
DMFeatureSelector >> extractConceptFrom: aName [

	| aConcept tokens|
	tokens := self tokenize: aName.
	aConcept := self selectConceptFrom: tokens.
	aConcept := self filter: aConcept.
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
DMFeatureSelector >> selectConceptFrom: tokens [

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
