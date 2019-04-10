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
ClassModelTest >> testClassModelSettersAndGetters [

	classModel class: DMClassModel.
	classModel className: 'DMClassModel'.
	classModel rootClass: (classModel extractRootClassFrom: DMClassModel).
	self assert: (classModel class) equals: DMClassModel.
	self assert: (classModel className) equals: 'DMClassModel'.
	self assert: (classModel rootClass) equals: DMClassModel.
]

{ #category : #tests }
ClassModelTest >> testCreateClassModelFromAClassWithAFeatureSelector [

	| featureSelector |
	featureSelector := DMFeatureSelector new.
	featureSelector 
		filterAllDigits: true; 
		stemming: true; 
		selectFirstSymbol: true.
	classModel createFrom: DMPackageModel with: featureSelector.
	self assert: (classModel class) equals: DMPackageModel.
	self assert: (classModel className) equals: 'DMPackageModel'.
	self assert: (classModel concept) equals: 'dm'.
	self assert: (classModel rootClass) equals: DMPackageModel.
	
]

{ #category : #tests }
ClassModelTest >> testEXtractConceptFromAClassName [

	| featureSelector aConcept |
	featureSelector := DMFeatureSelector new.
	featureSelector 
		filterAllDigits: true; 
		filterAllDigitsAndSpecialChars: true; 
		stemming: true; 	
		selectLastSymbol: true. 	
	aConcept := classModel extractConceptFrom: 'PackageModel' with: featureSelector .
	self assert: aConcept equals: 'model'.
	
]

{ #category : #tests }
ClassModelTest >> testExtractRootClassFromAClass [

	self assert: (classModel extractRootClassFrom: String) equals: Collection 
]

{ #category : #tests }
ClassModelTest >> testExtractRootClassFromObjectClass [

	| expectedRootClass featureSelector |
	featureSelector := DMFeatureSelector new.
	featureSelector
		filterAllDigits: true; 
		stemming: true; 
		selectFirstSymbol: true.
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
		stemming: true; 
		selectFirstSymbol: true.
	classModel createFrom: DMClassModel with: featureSelector.	
	actualRootClass := classModel extractRootClassFrom: classModel class .
	self assert: actualRootClass equals: expectedRootClass.

]
