Class {
	#name : #DMClassModelTest,
	#superclass : #TestCase,
	#category : #'DMFeatureSelector-Tests'
}

{ #category : #tests }
DMClassModelTest >> testCreateAClassModel [

	| classModel |
	classModel := DMClassModel new name: 'ClassName'; root: 'Superclass'.
	self assert: (classModel name) equals: 'ClassName'.
	self assert: (classModel concept) equals: 'Name'.
	self assert: (classModel root) equals: 'Superclass'.
]
