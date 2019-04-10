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

{ #category : #'as yet unclassified' }
DMFeatureSelector >> applyFeaturesOn: aCollectionOfPackages [

	| conceptualModel |
	conceptualModel := DMConceptualModel new.
	conceptualModel packages: aCollectionOfPackages.
	conceptualModel packageModels: 
		(conceptualModel packages collect: [ :aPackageName |	| packageModel |
			packageModel := DMPackageModel new. 
			packageModel packageName: aPackageName.
			packageModel classes: (packageModel extractClassesFrom: aPackageName).
			packageModel classModels: (packageModel classes collect: [ :aClass | | classModel | 
				classModel := DMClassModel new.
				classModel createFrom: aClass with: self ])  ]).
	^conceptualModel.
]

{ #category : #'as yet unclassified' }
DMFeatureSelector >> extractConceptFrom: aName [

	| aConcept tokens|
	tokens := self tokenize: aName.
	aConcept := self selectConceptFrom: tokens.
	aConcept := self filter: aConcept.
	aConcept := self stem: aConcept.
	^ aConcept
]

{ #category : #accessing }
DMFeatureSelector >> filter: aConcept [

	| symbol |
	symbol := aConcept.
	(filtererAllDigits) 
		ifTrue: [ symbol := filterer removeAllDigitsFrom: aConcept ].	
	(filterSpecialChars)
		ifTrue: [ symbol := filterer removeAllSpecialCharsFrom: symbol  ] .
	^ symbol

]

{ #category : #'as yet unclassified' }
DMFeatureSelector >> filterAllDigits: aBoolean [

	(aBoolean) 
		ifTrue: [ filtererAllDigits := true ] 
]

{ #category : #'as yet unclassified' }
DMFeatureSelector >> filterAllDigitsAndSpecialChars: aBoolean [

	aBoolean
		ifFalse: [ ^ self ].
	self filterAllDigits: true.
	self filterSpecialChars: true
]

{ #category : #accessing }
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

{ #category : #'as yet unclassified' }
DMFeatureSelector >> selectConceptFrom: tokens [

	(selectFirstSymbol) 
		ifTrue: [ ^ conceptualSymbolSelector selectFirstSymbolFrom: tokens ]
 		ifFalse: [ (selectMiddleSymbol)
							ifTrue: [ ^ conceptualSymbolSelector selectMiddleSymbolFrom: tokens ] 
							ifFalse: [ ^ conceptualSymbolSelector selectLastSymbolFrom: tokens ] ]
]

{ #category : #accessing }
DMFeatureSelector >> selectFirstSymbol [
	selectFirstSymbol := true.

]

{ #category : #accessing }
DMFeatureSelector >> selectLastSymbol. [
	selectLastSymbol := true.
]

{ #category : #accessing }
DMFeatureSelector >> selectMiddleSymbol [
	selectMiddleSymbol := true.

]

{ #category : #accessing }
DMFeatureSelector >> stem: aConcept [

	(stem) 
		ifTrue: [ ^tokenStemmer stemToken: aConcept ]
		ifFalse: [ ^ aConcept ]
]

{ #category : #accessing }
DMFeatureSelector >> stemming: aBoolean [

	(aBoolean) 
		ifTrue: [ stem := true ]
]

{ #category : #'as yet unclassified' }
DMFeatureSelector >> tokenize: aName [
	^ nameTokenizer cutWhereCamelCase: aName
]
