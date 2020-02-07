Class {
	#name : #FeatureSelectorTest,
	#superclass : #TestCase,
	#instVars : [
		'featureSelector'
	],
	#category : #'DMFeatureSelector-Tests'
}

{ #category : #running }
FeatureSelectorTest >> setUp [ 
	featureSelector := DMFeatureSelector new.
]

{ #category : #tests }
FeatureSelectorTest >> testEXtractConceptFromAClassName [

	| classModel aConcept |
	classModel := DMClassModel new.
	aConcept := featureSelector extractConceptFrom: DMPackageModel name.
	self assert: aConcept equals: 'Model'.
	
]

{ #category : #tests }
FeatureSelectorTest >> testExtractConceptFrom [

	self assert: (featureSelector extractConceptFrom: 'ClassName') equals: 'Name'
]

{ #category : #tests }
FeatureSelectorTest >> testExtractConceptFromNameByDefault [
	"extracts the last symbol by default, the last word in CamelCase without any filters"
	
	self assert: (featureSelector extractConceptFrom: 'ClassName34Blueprint') equals: 'Blueprint'.
	self assert: (featureSelector extractConceptFrom: 'ClassName34') equals: 'Name34'.
	self assert: (featureSelector extractConceptFrom: '%ClassName34%') equals: 'Name34%'.
	self assert: (featureSelector extractConceptFrom: '%Class%') equals: 'Class%'.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterAllSpecialCharsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterSpecialChars: true ; 
					extractConceptFrom: '12ClassName34Blueprint%./?'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterBothDigitsAndSpecialCharsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigitsAndSpecialChars: true; 
					extractConceptFrom: '12ClassName34Blueprint5%6/78'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterDigitsAndSpecialCharsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					filterSpecialChars: true ;
					extractConceptFrom: '12ClassName34Blueprint5%6/78'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilteringAllDigitsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					extractConceptFrom: '12ClassName34Blueprint56'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testStem [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					stemming: true;
					extractConceptFrom: '12ClassName34Building56'.
	expected := 'build'.
	self assert: actual equals: expected.

]

{ #category : #tests }
FeatureSelectorTest >> testStemLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					filterSpecialChars: true; 
					stemming: true;
					extractConceptFrom: '12ClassBuil23%ding'.
	expected := 'build'.
	self assert: actual equals: expected.

]
