Class {
	#name : #CNBFilterer,
	#superclass : #Object,
	#category : #CNBFeatureSelector
}

{ #category : #removing }
CNBFilterer class >> removeAllDigitsAndSpecialCharsFrom: aName [
	^ self new
		removeAllDigitsAndSpecialCharsFrom: aName
]

{ #category : #filtering }
CNBFilterer >> removeAllDigitsAndSpecialCharsFrom: aName [

	^ aName onlyLetters
]

{ #category : #filtering }
CNBFilterer >> removeAllDigitsFrom: aName [

	^ aName reject: #isDigit
]

{ #category : #filtering }
CNBFilterer >> removeAllSpecialCharsFrom: aName [

	^ aName select: [ :char | char isAlphaNumeric ]
]
