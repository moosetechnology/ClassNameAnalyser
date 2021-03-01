Class {
	#name : #CNBFiltererTest,
	#superclass : #TestCase,
	#instVars : [
		'filterer'
	],
	#category : #'CNBFeatureSelector-Tests'
}

{ #category : #running }
CNBFiltererTest >> setUp [ 
	filterer := CNBFilterer new.
]

{ #category : #tests }
CNBFiltererTest >> testRemoveAllDigitsAndSpecialCharsFromAlphaNumerics [

	self assert: (filterer removeAllDigitsAndSpecialCharsFrom: 'Class34%')  equals: 'Class'.
	self assert: (filterer removeAllDigitsAndSpecialCharsFrom: 'Class%34')  equals: 'Class'.
]

{ #category : #tests }
CNBFiltererTest >> testRemoveAllDigitsFromAlphaNumAndSpecialChars [

	self assert: (filterer removeAllDigitsFrom: 'Class1234%') equals: 'Class%'.

]

{ #category : #tests }
CNBFiltererTest >> testRemoveAllSpecialCharsFrom [

	self assert: (filterer removeAllSpecialCharsFrom: 'Class%?!' ) equals: 'Class'.
	self assert: (filterer removeAllSpecialCharsFrom: 'Class34%?!' )  equals: 'Class34'.
	self assert: (filterer removeAllSpecialCharsFrom: 'Class34%?!34' )  equals: 'Class3434'.
	self assert: (filterer removeAllSpecialCharsFrom: '%Class34%?!34' )  equals: 'Class3434'.
]
