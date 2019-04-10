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
		'stem',
		'selectLastSymbol',
		'selectMiddleSymbol',
		'selectFirstSymbol'
	],
	#category : #DMFeatureSelector
}

{ #category : #actions }
DMFeatureSelector >> applyFeaturesOn: aCollectionOfPackages [

	| conceptualModel |
	conceptualModel := DMConceptualModel new.
	conceptualModel packages: aCollectionOfPackages.
	conceptualModel packageModels: (conceptualModel packages collect: [ :aPackageName |		| packageModel |
		packageModel := DMPackageModel new. 
		packageModel packageName: aPackageName.
		packageModel classes: (packageModel extractClassesFrom: aPackageName).
		packageModel classModels: (packageModel classes collect: [ :aClass | | classModel | 
			classModel := DMClassModel new.
			classModel createFrom: aClass.
			classModel concept: (self extractConceptFrom: aClass name).
			classModel rootClass: (self extractRootClassFrom: aClass).
			])  ]).
	^conceptualModel.
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

	(aClass == Object)
		ifTrue: [ ^ aClass  ] 
		ifFalse: [ (aClass superclass == Object)
							ifTrue: [ ^ aClass  ]
							ifFalse: [  ^ self extractRootClassFrom: (aClass superclass)  ]		]
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

	(aBoolean) 
		ifTrue: [ filtererAllDigits := true ] 
]

{ #category : #setter }
DMFeatureSelector >> filterAllDigitsAndSpecialChars: aBoolean [

	aBoolean
		ifFalse: [ ^ self ].
	self filterAllDigits: true.
	self filterSpecialChars: true
]

{ #category : #setter }
DMFeatureSelector >> filterSpecialChars: aBoolean [

	(aBoolean) 
		ifTrue: [ filterSpecialChars := true ] 
]

{ #category : #initialization }
DMFeatureSelector >> initialize [ 

	super initialize.
	nameTokenizer := DMNameTokenizer new.
	tokenStemmer := DMTokenStemmer new.
	conceptualSymbolSelector := DMConceptualSymbolSelector new.
	filterer := DMFilterer new.
	stem := false.
	selectFirstSymbol := false.
	selectLastSymbol := false.
	selectMiddleSymbol := false.
	filtererAllDigits := false.
	filterSpecialChars := false.
]

{ #category : #actions }
DMFeatureSelector >> selectConceptFrom: tokens [
	"By default the selected concept is the last word"

	(selectFirstSymbol) 
		ifTrue: [ ^ conceptualSymbolSelector selectFirstSymbolFrom: tokens ]
 		ifFalse: [ (selectMiddleSymbol)
							ifTrue: [ ^ conceptualSymbolSelector selectMiddleSymbolFrom: tokens ] 
							ifFalse: [ ^ conceptualSymbolSelector selectLastSymbolFrom: tokens ] ]
]

{ #category : #setter }
DMFeatureSelector >> selectFirstSymbol: aBoolean [

	(aBoolean)
	ifTrue: [ selectFirstSymbol := true ]
	

]

{ #category : #setter }
DMFeatureSelector >> selectLastSymbol: aBoolean [

	(aBoolean)
	ifTrue: [ selectLastSymbol := true ]
]

{ #category : #setter }
DMFeatureSelector >> selectMiddleSymbol: aBoolean [
	
	(aBoolean)
	ifTrue: [ selectMiddleSymbol := true ]

]

{ #category : #actions }
DMFeatureSelector >> stem: aConcept [

	(stem) 
		ifTrue: [ ^tokenStemmer stemToken: aConcept ]
		ifFalse: [ ^ aConcept ]
]

{ #category : #setter }
DMFeatureSelector >> stemming: aBoolean [

	(aBoolean) 
		ifTrue: [ stem := true ]
]

{ #category : #actions }
DMFeatureSelector >> tokenize: aName [
	^ nameTokenizer cutWhereCamelCase: aName
]
