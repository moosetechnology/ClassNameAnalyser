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

	| featureSelectdor |
	featureSelectdor := DMFeatureSelector new.
	classModel theClass: DMClassModel.
	classModel rootClass: (featureSelectdor extractRootClassFrom: DMClassModel).
	classModel concept: (featureSelectdor extractConceptFrom: DMClassModel name).
	self assert: (classModel theClass) equals: DMClassModel.
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
	classModel createFrom: DMPackageModel..
	classModel rootClass: (featureSelector extractRootClassFrom: classModel theClass).
	classModel concept: (featureSelector extractConceptFrom: classModel theClass name).
	self assert: (classModel theClass) equals: DMPackageModel.
	self assert: (classModel className) equals: 'DMPackageModel'.
	self assert: (classModel concept) equals: 'dm'.
	self assert: (classModel rootClass) equals: DMPackageModel.
	
]
