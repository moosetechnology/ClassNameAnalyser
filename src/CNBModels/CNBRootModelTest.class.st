Class {
	#name : #CNBRootModelTest,
	#superclass : #TestCase,
	#instVars : [
		'rootModel'
	],
	#category : #CNBModels
}

{ #category : #running }
CNBRootModelTest >> setUp [
	super setUp.
	
	"Put here a common initialization logic for tests"
	rootModel 
	:= CNBRootModel new.
	rootModel  
			dominantTokens addAll: 
			({ ('I' -> 3 ) . 
			('Am'-> 5) . 
			('An'-> 20). 
			('Example'-> 2) } asDictionary); 
			yourself
]

{ #category : #tests }
CNBRootModelTest >> testBiggestTokenAssociation [ 

	self 
		assert: rootModel biggestTokenAssociation key
		equals: rootModel mainToken 
]

{ #category : #running }
CNBRootModelTest >> testMainToken [

	self 
		assert: rootModel mainToken 
		equals: 'An'
]
