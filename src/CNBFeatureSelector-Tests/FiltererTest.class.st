Class {
	#name : #FiltererTest,
	#superclass : #TestCase,
	#instVars : [
		'filterer'
	],
	#category : #'CNBFeatureSelector-Tests'
}

{ #category : #running }
FiltererTest >> setUp [ 
	filterer := DMFilterer new.
]

{ #category : #tests }
FiltererTest >> testRemoveAllDigitsAndSpecialCharsFromAlphaNumerics [

	self assert: (filterer removeAllDigitsAndSpecialCharsFrom: 'Class34%')  equals: 'Class'.
	self assert: (filterer removeAllDigitsAndSpecialCharsFrom: 'Class%34')  equals: 'Class'.
]

{ #category : #tests }
FiltererTest >> testRemoveAllDigitsFromAlphaNumAndSpecialChars [

	self assert: (filterer removeAllDigitsFrom: 'Class1234%') equals: 'Class%'.

]

{ #category : #tests }
FiltererTest >> testRemoveAllSpecialCharsFrom [

	self assert: (filterer removeAllSpecialCharsFrom: 'Class%?!' ) equals: 'Class'.
	self assert: (filterer removeAllSpecialCharsFrom: 'Class34%?!' )  equals: 'Class34'.
	self assert: (filterer removeAllSpecialCharsFrom: 'Class34%?!34' )  equals: 'Class3434'.
	self assert: (filterer removeAllSpecialCharsFrom: '%Class34%?!34' )  equals: 'Class3434'.
]
