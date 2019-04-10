Class {
	#name : #DMFeatureSelector,
	#superclass : #Object,
	#instVars : [
		'tokens',
		'concept',
		'filtererAllDigits',
		'filterer',
		'filterSpecialChars',
		'nameTokenizer',
		'tokenStemmer',
		'conceptualSymbolSelector',
		'stem',
		'selectLastSymbol',
		'selectMiddleSymbol',
		'selectFirstSymbol',
		'name'
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

	| aConcept |
	self name: aName.
	tokens := self tokenize.
	concept := self selectConcept.
	concept := self filter.
	concept := self stem.
	aConcept := concept deepCopy.
	^ aConcept
]

{ #category : #accessing }
DMFeatureSelector >> filter [ 

	| symbol |
	symbol := concept.
	(filtererAllDigits) 
		ifTrue: [ symbol := filterer removeAllDigitsFrom: concept ].	
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
	tokens := OrderedCollection new.
	stem := false.
	selectFirstSymbol := false.
	selectLastSymbol := false.
	selectMiddleSymbol := false.
	filtererAllDigits := false.
	filterSpecialChars := false.
]

{ #category : #accessing }
DMFeatureSelector >> name [ 
	^ name
]

{ #category : #accessing }
DMFeatureSelector >> name: aName [
	name := aName.
]

{ #category : #'as yet unclassified' }
DMFeatureSelector >> selectConcept [

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
DMFeatureSelector >> stem [ 

	(stem) 
		ifTrue: [ ^tokenStemmer stemToken: concept ]
		ifFalse: [ ^ concept ]
]

{ #category : #accessing }
DMFeatureSelector >> stem: aBoolean [

	(aBoolean) 
		ifTrue: [ stem := true ]
]

{ #category : #'as yet unclassified' }
DMFeatureSelector >> tokenize [
	^ nameTokenizer cutWhereCamelCase: name
]

{ #category : #accessing }
DMFeatureSelector >> tokens [
	^ tokens
]
