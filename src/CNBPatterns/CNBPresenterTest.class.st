Class {
	#name : #CNBPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'projectCnb',
		'cnbCanvas',
		'presenter',
		'roots',
		'allTokensModels',
		'allNodes',
		'tokenModels',
		'mooseModel'
	],
	#category : #CNBPatterns
}

{ #category : #tests }
CNBPresenterTest >> changeToCalypso [ 

	mooseModel := CNBMooseModelGenerator projectNameMatches: 'Calypso-*'.
	projectCnb := (
		(ClassNamesBlueprint new 
			model: mooseModel) 
			withSuffix) 
			startBuilding.
	roots := projectCnb viewModel rootModels collect: [ :each | each ].
	allTokensModels := projectCnb viewModel tokenModels reject: [ :each | each patterns isEmpty ].
]

{ #category : #running }
CNBPresenterTest >> setUp [
	super setUp.
	
	mooseModel := CNBMooseModelGenerator projectNameMatches: 'moose-*'.
	projectCnb := (
		(ClassNamesBlueprint new 
			model: mooseModel) 
			withSuffix) 
			startBuilding.
	roots := projectCnb viewModel rootModels collect: [ :each | each ].
	allTokensModels := projectCnb viewModel tokenModels reject: [ :each | each patterns isEmpty ].
]

{ #category : #checkPatternsInCNB }
CNBPresenterTest >> testCheckAllHomogeneous [
	| homogeneous |
	homogeneous := allTokensModels
							select: [ :each | each patterns anySatisfy: [ :aPattern |  aPattern isHomogeneous ] ].
	
	self 
		assert: (homogeneous collect: #color) asSet size equals: 1
]

{ #category : #checkPatternsInCNB }
CNBPresenterTest >> testCheckAllHomogeneousColorSize [
	| homogeneous |
	homogeneous := allTokensModels 
							select: [ :each | each patterns anySatisfy: [ :aPattern |  aPattern isHomogeneous ] ].
	
	self 
		assert: (homogeneous collect: #color) asSet size equals: 1
]

{ #category : #ScatteredVocabularyPattern }
CNBPresenterTest >> testCheckAllScatteredVocabularySizeInsidePackage [

	| scatteredVocabulary packageSuffixesDictionary packages |
	scatteredVocabulary 
	:= allTokensModels 
			select: [ :each |each patterns anySatisfy: [ :aPattern |  aPattern isScatteredVocabulary ] ].
	
	packages 
		:= (scatteredVocabulary collect: [ :each | each package ]) asSet.				
	packageSuffixesDictionary 
		:= (packages collect: [ :each | 
								each -> (scatteredVocabulary 
								select: [ :suffix | suffix package = each ]) ]) asDictionary.
							
	packageSuffixesDictionary do: [ :each | 
				each value addAll: (scatteredVocabulary 
				select: [ :suffix | suffix package = each ])  ].
	self 
		assert: (packageSuffixesDictionary values allSatisfy: [ :each | each size >= CNBScatteredVocabularyPattern new  minTokenSize ])  
		equals: true
]

{ #category : #ScatteredVocabularyPattern }
CNBPresenterTest >> testCheckAllScatteredVocabularySuffixSize [

	| scatteredVocabulary |
	scatteredVocabulary := allTokensModels 
							select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isScatteredVocabulary ]  ].
							
	
	self 
		assert: (scatteredVocabulary allSatisfy: [ :each | each size >= CNBScatteredVocabularyPattern new  minClassSize ])  
		equals: true
]

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckAllSnowFlakesColorSize [

	| snowFlakes |
	snowFlakes := allTokensModels 
							select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isSnowFlakes ]  ].
							
	
	self 
		assert: ((snowFlakes collect: #color) allSatisfy: [ :each | each isMonoClassColor ])  
		equals: true
]

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckAllSnowFlakesMaxSize [

	| snowFlakes |
	snowFlakes := allTokensModels 
							select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isSnowFlakes ]  ].
							
	
	self 
		assert: (snowFlakes allSatisfy: [ :each | each size >= CNBSnowFlakesPattern new snowFlakesSize ])  
		equals: true
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckConfetti [
	| aTokenModel |
	self changeToCalypso.

	aTokenModel := allTokensModels 
		detect: [ :each | 
			each name = 'Example' and: [ 
			each package name = 'Calypso-NavigationModel-Tests' ] ].
		
	aTokenModel checkConfetti.

	self
		assert: (aTokenModel patterns anySatisfy: [ :aPattern | aPattern isConfetti ] )	
		equals: true  
]

{ #category : #confettiTests }
CNBPresenterTest >> testCheckConfettiNumberInCNB [

	| confetti |
	confetti := allTokensModels select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isConfetti ]   ].
	
	self 
		assert: confetti size 
		equals: 0
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckFatBlob [
	| aTokenModel |

	aTokenModel := allTokensModels detect: [ :each | each package name = 'Moose-Algos-Graph-Tests' ].
		
	aTokenModel checkPatterns.
	
	self
		assert: (aTokenModel patterns anySatisfy: [ :aPattern | aPattern isFatBlob ])   
		equals: true
]

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testCheckHomogeneityBreaker [
	| aTokenModel  |
	self changeToCalypso.
	
	aTokenModel := allTokensModels 
		detect: [ :each | each name = 'Strategy' 
			and: [ each package name = 'Calypso-SystemTools-QueryBrowser' ] ].
			
	aTokenModel checkPatterns.
	
	self
		assert: (aTokenModel patterns anySatisfy: [ :aPattern | aPattern isHomogeneityBreaker ] 	)
		equals: true
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckHomogeneous [
	| aTokenModel  |

	aTokenModel := allTokensModels 
		detect: [ :each | each name = 'Strategy' 
			and: [ each package name = 'Moose-Query' ] ].
	
		
	aTokenModel checkPatterns.
	self
		assert: (aTokenModel patterns anySatisfy: [ :each | each isHomogeneous ] ) 
		
		equals: true  
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckIntruder [
	| aTokenModel |
	
	aTokenModel := allTokensModels detect: [ :each | each name = 'Command' ].
		
	aTokenModel checkPatterns.
	
	self
		assert: (aTokenModel patterns anySatisfy: [ :each | each isIntruder ]) 	
		equals: true  
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckScatteredVocabulary [
	| aTokenModel |
	
	aTokenModel := allTokensModels 
		detect: [ :each | each name = 'Task' 
							and: [ each package name = 'Moose-SmalltalkImporter' ] ].
		
	aTokenModel checkScatteredVocabulary.
	
	self
		assert: (aTokenModel patterns anySatisfy: [ :aPattern | aPattern isScatteredVocabulary] )
		equals: true  
]

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckSnowFlakes [
	| aTokenModel |
	
	aTokenModel := allTokensModels 
		detect: [ :each | each name = 'Engine' ].
	
		
	aTokenModel checkPatterns.
	
	self
		assert: (aTokenModel patterns anySatisfy: [ :each | each isSnowFlakes ] )	
		equals: true  
]

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckSnowFlakesInCNB [

	| snowFlakes actualSnowFlakes |
	snowFlakes := allTokensModels 
							select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern  isSnowFlakes]  ].
							
	actualSnowFlakes := { 'Engine' . 'B' }.
	
	self 
		assert: (snowFlakes collect: #name) asSet equals: actualSnowFlakes asSet
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

{ #category : #confettiTests }
CNBPresenterTest >> testConfettiOutsiders [

	| confetti |
	confetti 
		:= allTokensModels 
				select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isConfetti ] ].
	
	self 
		assert: (confetti allSatisfy: [ :each | 
						(each outsiders size <= CNBConfettiPattern new confettiPourcentage ) ])
		equals: true

	
]

{ #category : #confettiTests }
CNBPresenterTest >> testConfettiSize [

	| confetti |
	confetti := allTokensModels select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isConfetti ]   ].
	
	self 
		assert: (confetti allSatisfy: [ :each | 
						(each belongers size >= CNBConfettiPattern new confettiSize ) ])
		equals: true

	
]

{ #category : #FatBlobTests }
CNBPresenterTest >> testFatBlobsAreNotHomogeneous [

	| fatBlobs |
	fatBlobs := allTokensModels select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isFatBlob ]  ].

	self 
		assert: (fatBlobs anySatisfy: [ :each | each patterns anySatisfy: [ :pattern | pattern isHomogeneous ]  ])
		equals: false
]

{ #category : #FatBlobTests }
CNBPresenterTest >> testFatBlobsBelongToMultiSuffix [

	| fatBlobs |
	fatBlobs := allTokensModels select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isFatBlob ]   ].
	
	self 
		assert: (fatBlobs allSatisfy: [ :each | each root isMultiToken ])
		equals: true
]

{ #category : #FatBlobTests }
CNBPresenterTest >> testFatBlobsSize [

	| fatBlobs |
	fatBlobs := allTokensModels select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isFatBlob ] ].

	self 
		assert: (fatBlobs allSatisfy: [ :each | each size >= CNBFatBlobPattern new fatBlobSize ])
		equals: true
]

{ #category : #goDarker }
CNBPresenterTest >> testGoDarkerForFatBlob [ 


	| expectedBoxes expectedColors actualColors  |
	
	expectedBoxes := presenter goDarkerFor: #'Fat Blob'. 
	expectedColors := expectedBoxes collect: [ :each | each color ].
	self 
		assert: expectedColors  
		equals: actualColors  
	
	
	
	
	
]

{ #category : #goDarker }
CNBPresenterTest >> testGoDarkerForHomogeneityBreaker [
	
	| expectedFatBlobBoxes actualFatBlobBoxes suffixViewModels |
	
	expectedFatBlobBoxes := (presenter goDarkerFor: #'Homogeneity Breaker') 
	
]

{ #category : #goDarker }
CNBPresenterTest >> testGoDarkerForHomogeneous [
	
	| expectedBoxes actualBoxes classBoxes suffixBoxes |
	
	expectedBoxes := presenter nodesToHighlightFor: #'Homogeneous'. 
	suffixBoxes := allTokensModels 
		select: [ :each | each pattern isHomogeneous ].
	classBoxes := suffixBoxes flatCollect: [ :each | each classViewModels ].
	actualBoxes := suffixBoxes union: classBoxes.
		
	self 
		assert: expectedBoxes  
		equals: actualBoxes 
	
	
	
	
]

{ #category : #goDarker }
CNBPresenterTest >> testGoDarkerForScatteredVocabulary [
	| highlightedBoxes darkerBoxes expectedBoxesToGoDarker actualBoxesToGoDarker |
	
	highlightedBoxes := ((CNBPatternSelector of: projectCNB) 
			selectPatternOf: #'Scattered Vocabulary').
	expectedBoxesToGoDarker := presenter nodesToBeDarkerFor: #'Scattered Vocabulary'.
	actualBoxesToGoDarker := cnbCanvas deepNodes 
		reject: [ :each | highlightedBoxes includes: each model ].

	presenter lookFor: #'Scattered Vocabulary'.
	darkerBoxes := presenter nodesToBeDarkerFor: #'Scattered Vocabulary'.
	self 
		assert: highlightedBoxes size 
		equals: (presenter lookFor: #'Scattered Vocabulary') size.
]

{ #category : #goDarker }
CNBPresenterTest >> testGoDarkerForSnowFlakes [
	
	| expectedFatBlobBoxes actualFatBlobBoxes suffixViewModels |
	
	expectedFatBlobBoxes := (presenter goDarkerFor: #'Snow Flakes') 
	
]

{ #category : #highlighting }
CNBPresenterTest >> testHighlightConfetti [ 
	
	| expectedBoxes actualBoxes classBoxes suffixBoxes |
	self changeToCalypso.
	
	expectedBoxes := presenter nodesToHighlightFor: #'Confetti'. 
	
	suffixBoxes := allTokensModels 
		select: [ :each | each pattern isConfetti  ].
		
	classBoxes := suffixBoxes flatCollect: [ :each | each classViewModels ].
	
	actualBoxes := suffixBoxes union: classBoxes.
		
	self 
		assert: expectedBoxes  
		equals: actualBoxes 
]

{ #category : #highlighting }
CNBPresenterTest >> testHighlightFatBlob [

	| expectedBoxes actualBoxes classBoxes suffixBoxes |
	
	expectedBoxes := presenter nodesToHighlightFor: #'Fat Blob'. 
	
	suffixBoxes := allTokensModels 
		select: [ :each | each pattern isFatBlob ].
		
	classBoxes := suffixBoxes flatCollect: [ :each | each classViewModels ].
	
	actualBoxes := suffixBoxes union: classBoxes.
		
	self 
		assert: expectedBoxes  
		equals: actualBoxes asOrderedCollection
	
	
	
	
]

{ #category : #highlighting }
CNBPresenterTest >> testHighlightHomogeneityBreaker [

	| expectedBoxes actualBoxes classBoxes suffixBoxes |
	self changeToCalypso.
	
	expectedBoxes := presenter nodesToHighlightFor: #'Homogeneity Breaker'. 
	
	suffixBoxes := allTokensModels 
		select: [ :each | each pattern isHomogeneityBreaker ].
		
	classBoxes := suffixBoxes flatCollect: [ :each | each classViewModels ].
	
	actualBoxes := suffixBoxes union: classBoxes.
		
	self 
		assert: expectedBoxes  
		equals: actualBoxes 
	
	
	
	
]

{ #category : #highlighting }
CNBPresenterTest >> testHighlightIntruders [

	| expectedBoxes actualBoxes classBoxes suffixBoxes |
	
	expectedBoxes := presenter nodesToHighlightFor: #'Intruder'.
	 
	suffixBoxes := allTokensModels 
		select: [ :each | each pattern isIntruder ].
		
	classBoxes := suffixBoxes flatCollect: [ :each | each classViewModels ].
	
	actualBoxes := suffixBoxes union: classBoxes.
		
	self 
		assert: expectedBoxes  
		equals: actualBoxes 
	
	
	
	
]

{ #category : #highlighting }
CNBPresenterTest >> testHighlightScatteredVocabulary [


	| expectedBoxes actualBoxes classBoxes suffixBoxes |
	
	expectedBoxes := presenter nodesToHighlightFor: #'Scattered Vocabulary'. 
	
	suffixBoxes := allTokensModels 
		select: [ :each | each pattern isScatteredVocabulary ].
		
	classBoxes := suffixBoxes flatCollect: [ :each | each classViewModels ].
	
	actualBoxes := suffixBoxes union: classBoxes.
		
	self 
		assert: (expectedBoxes collect: #model) asOrderedCollection 
		equals: actualBoxes asOrderedCollection 
	
	
	
	
]

{ #category : #highlighting }
CNBPresenterTest >> testHighlightSnowFlakes [

	| expectedBoxes actualBoxes classBoxes suffixBoxes |
	
	expectedBoxes := presenter nodesToHighlightFor: #'Snow Flakes'. 
	
	suffixBoxes := allTokensModels 
		select: [ :each | each pattern isConfetti ].
		
	classBoxes := suffixBoxes flatCollect: [ :each | each classViewModels ].
	
	actualBoxes := suffixBoxes union: classBoxes.
		
	self 
		assert: expectedBoxes  
		equals: actualBoxes 
	
	
	
	
]

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testHomogeneityBreakerExists [

	| homogeneityBreakers |
	self changeToCalypso.
	homogeneityBreakers := allTokensModels  
			select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isHomogeneityBreaker]  ].
	
	self 
		assert: homogeneityBreakers isNotEmpty 
		equals: true
]

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testHomogeneityBreakerIsNotIntruder [

	| homoBreaker intruders |
	homoBreaker := allTokensModels 
			select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isHomogeneityBreaker ] ].
	intruders := allTokensModels 
			select: [ :each | each patterns anySatisfy: [ :pattern | pattern isIntruder ]  ].
			
	self
		assert: homoBreaker = intruders 
		equals: false
	
	
]

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testHomogeneityBreakersInCNB [

	| homogeneityBreakers |
	homogeneityBreakers := allTokensModels 
		select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isHomogeneityBreaker ] ].
		
	self 
		assert: homogeneityBreakers size 
		equals: 0
]

{ #category : #goDarker }
CNBPresenterTest >> testHomogeneousDarkerNodesDontIncludesHighlightedNodes [

	| highlightedNodes darkerNodes |
	presenter goDarkerFor: #'Homogeneous'.
	
	highlightedNodes := presenter nodesToHighlight.
	darkerNodes := presenter nodesToBeDarker.
	
		self 
			assert: (darkerNodes includesAll: highlightedNodes)
			equals: false
]

{ #category : #goDarker }
CNBPresenterTest >> testHomogeneousNodesGoDarkerColorName [

	| highlightedNodes |
	presenter goDarkerFor: #'Homogeneous'.
	highlightedNodes := presenter nodesToHighlight.
	self 
		assert: (highlightedNodes collect: #color) atRandom name
		equals: #gray
]

{ #category : #goDarker }
CNBPresenterTest >> testHomogeneousNodesGoDarkerColorSize [

	| highlightedNodes |
	presenter goDarkerFor: #'Homogeneous'.
	highlightedNodes := presenter nodesToHighlight.
	self 
		assert: (highlightedNodes collect: #color) asSet size 
		equals: 1
]

{ #category : #intrudersTests }
CNBPresenterTest >> testIntrudersAreNotMonoClasses [

	| intruders |
	intruders 
		:= allTokensModels 
			select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isIntruder ]  ].
																
	self 
		assert: (intruders anySatisfy: [ :each | each root isMonoClass ])
		equals: false
]

{ #category : #intrudersTests }
CNBPresenterTest >> testIntrudersPourcentage [

	| intruders |
	intruders := allTokensModels select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isIntruder ]  ].
																
	self 
		assert: (intruders allSatisfy: [ :each | each outsiders size <=  (each size * CNBIntruderPattern new intrudersPercentage) percent ])
		equals: true
]

{ #category : #intrudersTests }
CNBPresenterTest >> testIntrudersSizeInsideCNB [

	| intruders |
	intruders := allTokensModels select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isIntruder ]  ].
									
	self 
		assert: intruders size
		equals: 6
]

{ #category : #goDarker }
CNBPresenterTest >> testNodesGoDarker [

	| darkerNodes highlightedNodes |
	presenter goDarkerFor: #'Homogeneous'.
	highlightedNodes := presenter nodesToHighlight.
	self 
		assert: (highlightedNodes collect: #color) asSet size 
		equals: 1
]

{ #category : #tests }
CNBPresenterTest >> testNumberColorHighlighted [
	| highlightedBoxes |
	
	projectCNB := CNBRoassal3Builder projectNameMatches: 'moose-*'.
	
	highlightedBoxes := ((CNBPatternSelector of: projectCNB)
		selectPatternOf: #'Scattered Vocabulary').
		
	self assert: highlightedBoxes size equals: 3.
]

{ #category : #ScatteredVocabularyPattern }
CNBPresenterTest >> testScatteredVocabularyTokensSizeInCNB [

	| scatteredVocabulary |
	scatteredVocabulary 
		:= allTokensModels 
				select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isScatteredVocabulary ] ].
									
	self 
		assert: scatteredVocabulary size
		equals: 3
]
