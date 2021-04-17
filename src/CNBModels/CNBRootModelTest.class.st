Class {
	#name : #CNBRootModelTest,
	#superclass : #TestCase,
	#instVars : [
		'rootModel',
		'cnD',
		'testAsserterRoot',
		'traitRoot',
		'classBoxes'
	],
	#category : #CNBModels
}

{ #category : #tests }
CNBRootModelTest >> cnD [ 
	^ cnD
]

{ #category : #running }
CNBRootModelTest >> initializeCnD [ 

		cnD 
		:= ((ClassNamesBlueprint 
					modelGenerator projectNameMatches: 'moose-*') withSuffix) startBuilding.
		"Draw the Cnd on a canvas"
		cnD on: RSCanvas new
]

{ #category : #running }
CNBRootModelTest >> setUp [
	super setUp.
	
	"Put here a common initialization logic for tests"
	self initializeCnD.
	testAsserterRoot := cnD viewModel rootModels detectMax: [ :each | each size ].
	rootModel 
	:= CNBRootModel new.
	rootModel  
			tokensDictionary addAll: 
			({ ('I' -> 3 ) . 
			('Am'-> 5) . 
			('An'-> 20). 
			('Example'-> 2) } asDictionary); 
			yourself.
	traitRoot := cnD viewModel rootModels detect: [ :each | each model name = 'MalTEdgeNode' ].
	classBoxes := (cnD canvas deepNodes reject: [ :each | each hasChildren ]) select: [ :each | each hasModel ] .
		
]

{ #category : #tests }
CNBRootModelTest >> testBiggestRoot [ 

	|aRootModel |
	aRootModel := cnD viewModel rootModels detectMax: [ :each | each size ].
	self 
		assert: aRootModel name 
		equals: TestAsserter name
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

{ #category : #tests }
CNBRootModelTest >> testMonoRootBorderWidth [ 

	| monoRoot |
	
	"a box model is the class view model, model is the class model, model is the class"
	monoRoot := cnD viewModel rootModels detect: [ :each | each isMonoClass  ].
	
	self 
		assert: (classBoxes detect: [ :aBox | aBox model model model name = monoRoot model name ]) border width
		equals: CNBClassViewModel new rootBorderWidth 
]

{ #category : #tests }
CNBRootModelTest >> testRootIsTrait [ 

	
	self 
		assert: traitRoot isTrait
		equals: true.
		
	
]

{ #category : #tests }
CNBRootModelTest >> testRootMonoTokenColor [
	| monoToken tokenModels classVModels |
	
	monoToken 
		:= cnD viewModel 
					rootModels 
						detect: [ :each | each dominantTokens isNotEmpty and: [ each isMonoToken ]].
	tokenModels := monoToken tokenModels.
	classVModels :=  tokenModels flatCollect: #belongers.

	self 
		assert: monoToken color 
		equals: Color gray.
		
	self 
		assert: (tokenModels collect: #color) asSet 
		equals: {Color gray} asSet.
		
	self 
		assert: (classVModels collect: #color) asSet 
		equals: { Color gray } asSet.
	
	self 
		assert: (classVModels collect: #token) first
		equals: monoToken token
]

{ #category : #tests }
CNBRootModelTest >> testRootTraitBorder [

	| classBoxes |
	classBoxes 
		:= (cnD canvas deepNodes reject: [ :each | each hasChildren ]) select: [ :each | each hasModel ] .
	self
		assert:
			(classBoxes detect: [ :aNode | 
				 aNode model name = 'MalTEdgeNode' ]) border width
		equals: CNBClassViewModel new defaultBorderWidth
]

{ #category : #tests }
CNBRootModelTest >> testTestAsserterRoot [

	self 
		assert: testAsserterRoot name 
		equals: TestAsserter name
		
]

{ #category : #tests }
CNBRootModelTest >> testTestAsserterRootChangeColor [ 

	| tokens |
	(testAsserterRoot changeColorTo: Color yellow).
	tokens := testAsserterRoot tokenModels.
	self 
		assert: testAsserterRoot color
		equals: Color yellow.
		
	self
		assert: (tokens collect: #color) asSet hasOneElement
		equals: true.
		
	self 
		assert: (tokens collect: #color) first
		equals: Color yellow.
		
	self 
		assert: ((tokens flatCollect: #belongers) collect: #color) asSet hasOneElement 
		equals: true.
		
	self 
		assert: ((tokens flatCollect: #belongers) collect: #color) asSet atRandom
		equals: Color yellow
		
	
	
]

{ #category : #tests }
CNBRootModelTest >> testTestAsserterRootColor [

	self 
		assert: testAsserterRoot color 
		equals: Color red
]

{ #category : #tests }
CNBRootModelTest >> testTestAsserterRootType [

	self 
		assert: testAsserterRoot isMultiToken 
		equals: true
]
