Class {
	#name : #DMClassModelTest,
	#superclass : #TestCase,
	#category : #'DMFeatureSelector-Tests'
}

{ #category : #tests }
DMClassModelTest >> testCreateAClassModel [

	| classModel |
	classModel := DMClassModel name: 'ClassName' with: 'Superclass'.
	self assert: (classModel name) equals: 'ClassName'.
	self assert: (classModel concept) equals: 'Name'.
	self assert: (classModel root) equals: 'Superclass'.
]
