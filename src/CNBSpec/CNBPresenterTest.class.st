Class {
	#name : #CNBPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'projectCNB',
		'cnbCanvas',
		'presenter',
		'roots',
		'suffixModels'
	],
	#category : #CNBSpec
}

{ #category : #tests }
CNBPresenterTest >> changeToCalypso [ 
	projectCNB := CNBRoassal3Builder projectNameMatches: 'calypso-*'.
	presenter projectSelector text: 'calypso-*'. 
	presenter onLoadProjectClicked.
	presenter cnbSpecView openWithSpec.
	suffixModels := projectCNB viewModel suffixModels.
]

{ #category : #running }
CNBPresenterTest >> setUp [
	super setUp.
	
	presenter := CNBPresenter new.
	projectCNB := CNBRoassal3Builder projectNameMatches: 'moose-*'.
	roots := projectCNB viewModel rootModels collect: [ :each | each ].
	cnbCanvas := projectCNB on: RSCanvas new.
	presenter projectSelector text: 'moose-*'. 
	presenter onLoadProjectClicked.
	presenter cnbSpecView openWithSpec.
	suffixModels := projectCNB viewModel suffixModels.
]

{ #category : #tests }
CNBPresenterTest >> testCanvasNotNil [


	self assert: presenter cnbSpecView canvas isNotNil equals: true
]

{ #category : #tests }
CNBPresenterTest >> testCheckConfetti [
	| aSuffixModel expectedPatterns actualPatterns |
	self changeToCalypso.
	
	actualPatterns :=  #'Confetti'.
	
	aSuffixModel := suffixModels 
		detect: [ :each | each name = 'Example' 
			and: [ each package = 'Calypso-NavigationModel-Tests' ] ].
	
		
	aSuffixModel checkPatterns.
	
	expectedPatterns := aSuffixModel patterns detect: [ :each | each name = #'Confetti' ].
	
	self
		assert: expectedPatterns name
		
		equals: actualPatterns  
]

{ #category : #tests }
CNBPresenterTest >> testCheckFatBlob [
	| aSuffixModel expectedPatterns actualPatterns |
	actualPatterns := { #'Fat Blob'}.
	
	aSuffixModel := suffixModels 
		detect: [ :each | each package = 'Moose-Algos-Graph-Tests'].
		
	aSuffixModel checkPatterns.
	
	expectedPatterns := aSuffixModel patterns.
	
	self
		assert: (expectedPatterns collect: #name) asSet
		equals: actualPatterns asSet 
]

{ #category : #tests }
CNBPresenterTest >> testCheckHomogeneous [
	| aSuffixModel expectedPatterns actualPatterns |
	
	actualPatterns :=  #'Homogeneous'.
	
	aSuffixModel := suffixModels 
		detect: [ :each | each name = 'Strategy' 
			and: [ each package = 'Moose-Query' ] ].
	
		
	aSuffixModel checkPatterns.
	
	expectedPatterns := aSuffixModel patterns detect: [ :each | each name = #'Homogeneous' ].
	
	self
		assert: expectedPatterns name
		
		equals: actualPatterns  
]

{ #category : #tests }
CNBPresenterTest >> testCheckIntruder [
	| aSuffixModel expectedPatterns actualPatterns |
	
	actualPatterns :=  #'Intruder'.
	
	aSuffixModel := suffixModels 
		detect: [ :each | each name = 'Command' ].
	
		
	aSuffixModel checkPatterns.
	
	expectedPatterns := aSuffixModel patterns detect: [ :each | each name = #'Intruder' ].
	
	self
		assert: expectedPatterns name
		
		equals: actualPatterns  
]

{ #category : #tests }
CNBPresenterTest >> testCheckSnowFlakes [
	| aSuffixModel expectedPatterns actualPatterns |
	
	actualPatterns :=  #'Snow Flakes'.
	
	aSuffixModel := suffixModels 
		detect: [ :each | each name = 'Engine' ].
	
		
	aSuffixModel checkPatterns.
	
	expectedPatterns := aSuffixModel patterns detect: [ :each | each name = #'Snow Flakes' ].
	
	self
		assert: expectedPatterns name
		
		equals: actualPatterns  
]

{ #category : #tests }
CNBPresenterTest >> testColorHighlighted [
	| highlightedBoxes |

	
	highlightedBoxes := ((CNBPatternSelector of: projectCNB)
		selectPatternOf: #'Scattered Vocabulary').
		
	self
		assert: (highlightedBoxes collect: #color) asSet
		equals: { Color purple } asSet 
]

{ #category : #tests }
CNBPresenterTest >> testGoDarker [
	| highlightedBoxes darkerBoxes expectedBoxesToGoDarker actualBoxesToGoDarker |
	
	highlightedBoxes := ((CNBPatternSelector of: projectCNB) 
			selectPatternOf: #'Scattered Vocabulary').
	expectedBoxesToGoDarker := presenter boxesToBeDarkerFor: #'Scattered Vocabulary'.
	actualBoxesToGoDarker := cnbCanvas deepNodes 
		reject: [ :each | highlightedBoxes includes: each model ].

	presenter lookFor: #'Scattered Vocabulary'.
	darkerBoxes := presenter boxesToBeDarkerFor: #'Scattered Vocabulary'.
	self 
		assert: highlightedBoxes size 
		equals: (presenter lookFor: #'Scattered Vocabulary') size.
]

{ #category : #tests }
CNBPresenterTest >> testGoDarkerForFatBlob [
	
	| expectedDarkerBoxes actualDarkerBoxes suffixViewModels fatBlobs |
	
	(presenter goDarkerFor: #'Fat Blob').
	fatBlobs := (presenter boxesToBeDarkerFor: #'Fat Blob') 
		collect: [ :each | each ].
	expectedDarkerBoxes := (presenter cnbSpecView canvas deepNodes collect: [ :each | each model ])
		reject: fatBlobs.
	
	suffixViewModels := roots 
		flatCollect: [ :each | each concepts ].
	actualDarkerBoxes := suffixViewModels 
		select: [ :each | (each patterns collect: #name) includes: #'Fat Blob' ].
	
	self 
		assert: (expectedDarkerBoxes collect: #package) asSet 
		equals: (actualDarkerBoxes collect: #package)
	
]

{ #category : #tests }
CNBPresenterTest >> testHomogeneous [

	| cnb homogeneousPackage homogeneousModel |
	cnb := DMClassNamesBlueprintSample projectNameMatches: 'moose-*'.
	homogeneousPackage := cnb viewModel models detect: [ :package | 
		                      package name = 'Moose-MenuBar' ].

	homogeneousModel := homogeneousPackage models asOrderedCollection
		                    first.
	self assert: homogeneousModel checkHomogeneous equals: true.

]

{ #category : #tests }
CNBPresenterTest >> testLookForFatBlob [
	
	| expectedFatBlobBoxes actualFatBlobBoxes suffixViewModels |
	
	expectedFatBlobBoxes := (presenter lookFor: #'Fat Blob') 
		collect: [ :each | each ] .
	
	suffixViewModels := roots 
		flatCollect: [ :each | each concepts ].
	actualFatBlobBoxes := suffixViewModels 
		select: [ :each | (each patterns collect: #name) includes: #'Fat Blob' ].
	
	self 
		assert: (expectedFatBlobBoxes collect: #package) asSet 
		equals: (actualFatBlobBoxes collect: #package)
	
]

{ #category : #tests }
CNBPresenterTest >> testNotHomogeneous [

	| cnb notHomogeneousPackage notHomogeneousModel |
	cnb := DMClassNamesBlueprintSample projectNameMatches: 'moose-*'.

	notHomogeneousPackage := cnb viewModel models detect: [ :package | 
		                         package name = 'Moose-Algos-Graph' ].

	notHomogeneousModel := notHomogeneousPackage models
		                       asOrderedCollection first. 
		self assert: notHomogeneousModel checkHomogeneous equals: false
]

{ #category : #tests }
CNBPresenterTest >> testNumberColorHighlighted [
	| highlightedBoxes |
	
	projectCNB := CNBRoassal3Builder projectNameMatches: 'moose-*'.
	
	highlightedBoxes := ((CNBPatternSelector of: projectCNB)
		selectPatternOf: #'Scattered Vocabulary').
		
	self assert: highlightedBoxes size equals: 3.
]

{ #category : #tests }
CNBPresenterTest >> testSelectFatBlobs [
	
	| expectedFatBlobBoxes actualFatBlobBoxes suffixViewModels |
	
	expectedFatBlobBoxes := (presenter lookFor: #'Fat Blob') 
		collect: [ :each | each ] .
	
	suffixViewModels := roots 
		flatCollect: [ :each | each concepts ].
	actualFatBlobBoxes := suffixViewModels 
		select: [ :each | each checkFatBlob ].
	
	self 
		assert: (expectedFatBlobBoxes collect: #package) asSet 
		equals: (actualFatBlobBoxes collect: #package)
	
]
