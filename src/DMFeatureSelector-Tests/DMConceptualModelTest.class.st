Class {
	#name : #DMConceptualModelTest,
	#superclass : #TestCase,
	#instVars : [
		'conceptualModel'
	],
	#category : #'DMFeatureSelector-Tests'
}

{ #category : #running }
DMConceptualModelTest >> setUp [ 
	conceptualModel := DMConceptualModel new.
]

{ #category : #tests }
DMConceptualModelTest >> testSettersAndGetters [

	| firstPackageModel secondPackageModel aCollectionOfPackageModels |
	firstPackageModel := DMPackageModel new.
	secondPackageModel := DMPackageModel new.
	aCollectionOfPackageModels := OrderedCollection new.
	aCollectionOfPackageModels 
		add: firstPackageModel; 
		add: secondPackageModel.
	conceptualModel packages:  { 'Kernel' . 'DMFeatureSelector' }.
	conceptualModel packageModels: aCollectionOfPackageModels.
	self assert: (conceptualModel packages) equals: { 'Kernel' . 'DMFeatureSelector' }.
	self assert: (conceptualModel packageModels) equals: { firstPackageModel . secondPackageModel } 	asOrderedCollection.
]
