Class {
	#name : #CNBPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'projectCNB',
		'cnbCanvas',
		'presenter',
		'roots',
		'suffixModels',
		'allNodes'
	],
	#category : #CNBPatterns
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
	allNodes := cnbCanvas deepNodes.
]

{ #category : #tests }
CNBPresenterTest >> testCanvasNotNil [


	self assert: presenter cnbSpecView canvas isNotNil equals: true
]

{ #category : #checkPatternsInCNB }
CNBPresenterTest >> testCheckAllHomogeneous [
	| homogeneous |
	homogeneous := suffixModels 
							select: [ :each | (each patterns collect: #name) includes: #'Snow Flakes' ].
	
	self 
		assert: (homogeneous collect: #color) asSet size equals: 1
]

{ #category : #checkPatternsInCNB }
CNBPresenterTest >> testCheckAllHomogeneousColorSize [
	| homogeneous |
	homogeneous := suffixModels 
							select: [ :each | (each patterns collect: #name) includes: #'Snow Flakes' ].
	
	self 
		assert: (homogeneous collect: #color) asSet size equals: 1
]

{ #category : #ScatteredVocabularyPattern }
CNBPresenterTest >> testCheckAllScatteredVocabularyInsidePackageSize [

	| scatteredVocabulary packageSuffixesDictionary packages |
	scatteredVocabulary := suffixModels 
							select: [ :each | (each patterns collect: #name) includes: #'Scattered Vocabulary' ].
	
	packages := (scatteredVocabulary 
							collect: [ :each | each package ]) asSet.				
	packageSuffixesDictionary := (packages 
							collect: [ :each | 
								each -> (scatteredVocabulary 
								select: [ :suffix | suffix package = each ]) ]) asDictionary.
							
	packageSuffixesDictionary do: [ :each | 
				each value addAll: (scatteredVocabulary 
				select: [ :suffix | suffix package = each ])  ].
	self 
		assert: (packageSuffixesDictionary values allSatisfy: [ :each | each size >= CNBPatternSelector svMinSuffixSize ])  
		equals: true
]

{ #category : #ScatteredVocabularyPattern }
CNBPresenterTest >> testCheckAllScatteredVocabularySuffixHasNoOutsiders [

	| scatteredVocabulary |
	scatteredVocabulary := suffixModels 
							select: [ :each | (each patterns collect: #name) includes: #'Scattered Vocabulary' ].
							
	
	self 
		assert: (scatteredVocabulary allSatisfy: [ :each | each hasNoOutsiders ])  
		equals: true
]

{ #category : #ScatteredVocabularyPattern }
CNBPresenterTest >> testCheckAllScatteredVocabularySuffixSize [

	| scatteredVocabulary |
	scatteredVocabulary := suffixModels 
							select: [ :each | (each patterns collect: #name) includes: #'Scattered Vocabulary' ].
							
	
	self 
		assert: (scatteredVocabulary allSatisfy: [ :each | each size >= CNBPatternSelector svMinClassSize ])  
		equals: true
]

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckAllSnowFlakesColorSize [

	| snowFlakes |
	snowFlakes := suffixModels 
							select: [ :each | (each patterns collect: #name) includes: #'Snow Flakes' ].
							
	
	self 
		assert: ((snowFlakes collect: #color) allSatisfy: [ :each | each isMonoClassColor ])  
		equals: true
]

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckAllSnowFlakesMaxSize [

	| snowFlakes |
	snowFlakes := suffixModels 
							select: [ :each | (each patterns collect: #name) includes: #'Snow Flakes' ].
							
	
	self 
		assert: (snowFlakes allSatisfy: [ :each | each size >= CNBPatternSelector snowFlakesSize ])  
		equals: true
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckConfetti [
	| aSuffixModel expectedPatterns actualPatterns |
	self changeToCalypso.
	
	actualPatterns :=  #'Confetti'.
	
	aSuffixModel := suffixModels 
		detect: [ :each | each name = 'Example' 
			and: [ each package = 'Calypso-NavigationModel-Tests' ] ].
	
		
	aSuffixModel checkConfetti.
	
	expectedPatterns := aSuffixModel patterns detect: [ :each | each name = #'Confetti' ].
	self
		assert: expectedPatterns name
		
		equals: actualPatterns  
]

{ #category : #confettiTests }
CNBPresenterTest >> testCheckConfettiNumberInCNB [

	| confetti |
	confetti := suffixModels select: [ :each | (each patterns collect: #name) includes: #'Confetti' ].
	
	self 
		assert: confetti size 
		equals: 1
]

{ #category : #checkingOneSuffixPattern }
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

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testCheckHomogeneityBreaker [
	| aSuffixModel expectedPatterns actualPatterns |
	self changeToCalypso.
	actualPatterns :=  #'Homogeneity Breaker'.
	
	aSuffixModel := suffixModels 
		detect: [ :each | each name = 'Strategy' 
			and: [ each package = 'Calypso-SystemTools-QueryBrowser' ] ].
	
		
	aSuffixModel checkPatterns.
	
	expectedPatterns := aSuffixModel patterns 
		detect: [ :each | each name = #'Homogeneity Breaker' ].
	
	self
		assert: expectedPatterns name
		
		equals: actualPatterns  
]

{ #category : #checkingOneSuffixPattern }
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

{ #category : #checkingOneSuffixPattern }
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

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckScatteredVocabulary [
	| aSuffixModel expectedPatterns actualPatterns |
	
	actualPatterns :=  #'Scattered Vocabulary'.
	
	aSuffixModel := suffixModels 
		detect: [ :each | each name = 'Task' 
							and: [ each package = 'Moose-SmalltalkImporter' ] ].
	
		
	aSuffixModel checkScatteredVocabulary.
	expectedPatterns := (aSuffixModel patterns collect: #name) 
									includes: #'Scattered Vocabulary' .
	self
		assert: expectedPatterns
		equals: true  
]

{ #category : #SnowFlakesTest }
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

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckSnowFlakesInCNB [

	| snowFlakes actualSnowFlakes |
	snowFlakes := suffixModels 
							select: [ :each | (each patterns collect: #name) includes: #'Snow Flakes' ].
							
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
	confetti := suffixModels select: [ :each | (each patterns collect: #name) includes: #'Confetti' ].
	
	self 
		assert: (confetti allSatisfy: [ :each | 
						(each outsiders size <= CNBPatternSelector confettiPourcentage ) ])
		equals: true

	
]

{ #category : #confettiTests }
CNBPresenterTest >> testConfettiSize [

	| confetti |
	confetti := suffixModels select: [ :each | (each patterns collect: #name) includes: #'Confetti' ].
	
	self 
		assert: (confetti allSatisfy: [ :each | 
						(each belongers size >= CNBPatternSelector confettiSize ) ])
		equals: true

	
]

{ #category : #FatBlobTests }
CNBPresenterTest >> testFatBlobsAreNotHomogeneous [

	| fatBlobs |
	fatBlobs := suffixModels select: [ :each | (each patterns collect: #name) includes: #'Fat Blob' ].
	

	self 
		assert: (fatBlobs anySatisfy: [ :each | (each patterns collect: #name ) 
					includes: #'Homogenerous'])
		equals: false
]

{ #category : #FatBlobTests }
CNBPresenterTest >> testFatBlobsBelongToMultiSuffix [

	| fatBlobs |
	fatBlobs := suffixModels select: [ :each | (each patterns collect: #name) includes: #'Fat Blob' ].
	

	self 
		assert: (fatBlobs allSatisfy: [ :each | each root isMultiSuffix ])
		equals: true
]

{ #category : #FatBlobTests }
CNBPresenterTest >> testFatBlobsHasNoOutsiders [

	| fatBlobs |
	fatBlobs := suffixModels select: [ :each | (each patterns collect: #name) includes: #'Fat Blob' ].
	

	self 
		assert: (fatBlobs allSatisfy: [ :each | each outsiders isEmpty ])
		equals: true
]

{ #category : #FatBlobTests }
CNBPresenterTest >> testFatBlobsSize [

	| fatBlobs |
	fatBlobs := suffixModels select: [ :each | (each patterns collect: #name) includes: #'Fat Blob' ].
	

	self 
		assert: (fatBlobs allSatisfy: [ :each | each size >= CNBPatternSelector fatBlobSize ])
		equals: true
]

{ #category : #goDarker }
CNBPresenterTest >> testGoDarkerForFatBlob [ 


	| expectedBoxes expectedColors actualColors  |
	
	expectedBoxes := presenter nodesToBeDarkerFor: #'Fat Blob'. 
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
	suffixBoxes := suffixModels 
		select: [ :each | (each patterns collect: #name) includes: #'Homogeneous' ].
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
	
	suffixBoxes := suffixModels 
		select: [ :each | (each patterns collect: #name) includes: #'Confetti' ].
		
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
	
	suffixBoxes := suffixModels 
		select: [ :each | (each patterns collect: #name) includes: #'Fat Blob' ].
		
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
	
	suffixBoxes := suffixModels 
		select: [ :each | (each patterns collect: #name) includes: #'Homogeneity Breaker' ].
		
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
	 
	suffixBoxes := suffixModels 
		select: [ :each | (each patterns collect: #name) includes: #'Intruder' ].
		
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
	
	suffixBoxes := suffixModels 
		select: [ :each | (each patterns collect: #name) includes: #'Scattered Vocabulary' ].
		
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
	
	suffixBoxes := suffixModels 
		select: [ :each | (each patterns collect: #name) includes: #'Snow Flakes' ].
		
	classBoxes := suffixBoxes flatCollect: [ :each | each classViewModels ].
	
	actualBoxes := suffixBoxes union: classBoxes.
		
	self 
		assert: expectedBoxes  
		equals: actualBoxes 
	
	
	
	
]

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testHomogeneityBreakerExists [

	| homogeneityBreakers |
	homogeneityBreakers := suffixModels 
			select: [ :each | (each patterns collect: #name) includes: #'Homogeneity Breaker' ].
	
	self 
		assert: homogeneityBreakers isNotEmpty 
		equals: true
]

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testHomogeneityBreakerIsNotIntruder [

	| homoBreaker intruders |
	homoBreaker := suffixModels 
			select: [ :each | (each patterns collect: #name) includes: #'Homogeneity Breaker'  ].
	intruders := suffixModels 
			select: [ :each | (each patterns collect: #name) includes: #'Intruder' ].
			
	self
		assert: homoBreaker = intruders 
		equals: false
	
	
]

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testHomogeneityBreakersInCNB [

	| homogeneityBreakers |
	homogeneityBreakers := suffixModels 
		select: [ :each | (each patterns collect: #name) includes: #'Homogeneity Breaker' ].
		
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
	intruders := suffixModels select: [ :each | (each patterns collect: #name) 
										includes: #'Intruder' ].
																
	self 
		assert: (intruders anySatisfy: [ :each | each root isMonoClass ])
		equals: false
]

{ #category : #intrudersTests }
CNBPresenterTest >> testIntrudersPourcentage [

	| intruders |
	intruders := suffixModels select: [ :each | (each patterns collect: #name) 
										includes: #'Intruder' ].
																
	self 
		assert: (intruders allSatisfy: [ :each | each outsiders size <=  (each size * CNBPatternSelector intrudersPercentage) percent ])
		equals: true
]

{ #category : #intrudersTests }
CNBPresenterTest >> testIntrudersSizeInsideCNB [

	| intruders |
	intruders := suffixModels select: [ :each | (each patterns collect: #name) 
										includes: #'Intruder' ].
									
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
CNBPresenterTest >> testScatteredVocabularySuffixesSizeInCNB [

	| scatteredVocabulary |
	scatteredVocabulary := suffixModels select: [ :each | (each patterns collect: #name) 
										includes: #'Scattered Vocabulary' ].
									
	self 
		assert: scatteredVocabulary size
		equals: 3
]
