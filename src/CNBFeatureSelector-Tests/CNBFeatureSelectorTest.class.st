Class {
	#name : #CNBFeatureSelectorTest,
	#superclass : #TestCase,
	#instVars : [
		'featureSelector'
	],
	#category : #'CNBFeatureSelector-Tests'
}

{ #category : #running }
CNBFeatureSelectorTest >> setUp [ 
	featureSelector := CNBFeatureSelector new.
]

{ #category : #tests }
CNBFeatureSelectorTest >> testEXtractConceptFromAClassName [

	| classModel aConcept |
	classModel := CNBClassModel new.
	aConcept := featureSelector extractSuffixFrom: CNBPackageModel name.
	self assert: aConcept equals: 'Model'.
	
]

{ #category : #tests }
CNBFeatureSelectorTest >> testExtractConceptFrom [

	self assert: (featureSelector extractSuffixFrom: 'ClassName') equals: 'Name'
]

{ #category : #tests }
CNBFeatureSelectorTest >> testExtractConceptFromNameByDefault [
	"extracts the last symbol by default, the last word in CamelCase without any filters"
	
	self assert: (featureSelector extractSuffixFrom: 'ClassName34Blueprint') equals: 'Blueprint'.
	self assert: (featureSelector extractSuffixFrom: 'ClassName34') equals: 'Name'.
	self assert: (featureSelector extractSuffixFrom: '%ClassName34%') equals: 'Name'.
	self assert: (featureSelector extractSuffixFrom: '%Class%') equals: 'Class'.
]

{ #category : #tests }
CNBFeatureSelectorTest >> testFilterAllSpecialCharsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterSpecialChars: true ; 
					extractSuffixFrom: '12ClassName34Blueprint%./?'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
CNBFeatureSelectorTest >> testFilterBothDigitsAndSpecialCharsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigitsAndSpecialChars: true; 
					extractSuffixFrom: '12ClassName34Blueprint5%6/78'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
CNBFeatureSelectorTest >> testFilterDigitsAndSpecialCharsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					filterSpecialChars: true ;
					extractSuffixFrom: '12ClassName34Blueprint5%6/78'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
CNBFeatureSelectorTest >> testFilteringAllDigitsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					extractSuffixFrom: '12ClassName34Blueprint56'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
CNBFeatureSelectorTest >> testStem [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					stemming: true;
					extractSuffixFrom: '12ClassName34Building56'.
	expected := 'build'.
	self assert: actual equals: expected.

]

{ #category : #tests }
CNBFeatureSelectorTest >> testStemLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					filterSpecialChars: true; 
					stemming: true;
					extractSuffixFrom: '12ClassBuil23%ding'.
	expected := 'build'.
	self assert: actual equals: expected.

]
