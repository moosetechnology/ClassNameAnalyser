Class {
	#name : #ClassModelTest,
	#superclass : #TestCase,
	#instVars : [
		'classModel'
	],
	#category : #'DMFeatureSelector-Tests'
}

{ #category : #running }
ClassModelTest >> setUp [
	classModel := DMClassModel new.
]

{ #category : #tests }
ClassModelTest >> testClassWith [

	| featureSelector |
	featureSelector := DMFeatureSelector new.
	featureSelector 
		filterAllDigits: true; 
		stem: true; 
		selectFirstSymbol.
	classModel createFrom: DMPackageModel with: featureSelector.
	self assert: (classModel class) equals: DMPackageModel.
	self assert: (classModel className) equals: 'DMPackageModel'.
	self assert: (classModel concept) equals: 'dm'.
	self assert: (classModel rootClass) equals: DMPackageModel.
	
]

{ #category : #tests }
ClassModelTest >> testEXtractConceptFrom [

	| featureSelector aConcept |
	featureSelector := DMFeatureSelector new.
	featureSelector 
		filterAllDigits: true; 
		filterAllDigitsAndSpecialChars: true; 
		stem: true; 	
		selectLastSymbol.  	
	aConcept := classModel extractConceptFrom: 'PackageModel' with: featureSelector .
	self assert: aConcept equals: 'model'.
	
]

{ #category : #tests }
ClassModelTest >> testExtractRootClassFrom [

	self assert: (classModel extractRootClassFrom: String) equals: Collection 
]

{ #category : #tests }
ClassModelTest >> testExtractRootClassFromObject [

	| expectedRootClass featureSelector |
	featureSelector := DMFeatureSelector new.
	featureSelector
		filterAllDigits: true; 
		stem: true; 
		selectFirstSymbol.
	expectedRootClass := Object.
	classModel createFrom: Object with: featureSelector.
	self assert: expectedRootClass equals: Object.

]

{ #category : #tests }
ClassModelTest >> testExtractRootClassNoHierarchy [

	| expectedRootClass actualRootClass featureSelector|
	
	expectedRootClass := DMClassModel.
	featureSelector := DMFeatureSelector new.
	featureSelector 
		filterAllDigits: true; 
		stem: true; 
		selectFirstSymbol.
	classModel createFrom: DMClassModel with: featureSelector.	
	actualRootClass := classModel extractRootClassFrom: classModel class .
	self assert: actualRootClass equals: expectedRootClass.

]
