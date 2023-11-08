Class {
	#name : #CNBPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'allTokenModelsInMoose',
		'allTokenModelsInCalypso'
	],
	#category : #'CNBPatterns-Tests'
}

{ #category : #running }
CNBPresenterTest >> allNonEmptyTokensInPackagesMatching: aPattern [

	| cnb |
	cnb := (ClassNamesBlueprint projectNameMatches: aPattern) withSuffix
		       startBuilding.

	^ cnb viewModel tokenModels reject: [ :each | each patterns isEmpty ]
]

{ #category : #running }
CNBPresenterTest >> setUp [

	super setUp.

	allTokenModelsInMoose := self allNonEmptyTokensInPackagesMatching:
		                         'Moose-*'.
	allTokenModelsInCalypso := self allNonEmptyTokensInPackagesMatching:
		                           'Calypso-*'
]

{ #category : #checkPatternsInCNB }
CNBPresenterTest >> testCheckAllHomogeneous [
	| homogeneous |
	homogeneous := allTokenModelsInMoose
							select: [ :each | each patterns anySatisfy: [ :aPattern |  aPattern isHomogeneous ] ].
	
	self 
		assert: (homogeneous collect: #color) asSet size equals: 1
]

{ #category : #checkPatternsInCNB }
CNBPresenterTest >> testCheckAllHomogeneousColorSize [
	| homogeneous |
	homogeneous := allTokenModelsInMoose 
							select: [ :each | each patterns anySatisfy: [ :aPattern |  aPattern isHomogeneous ] ].
	
	self 
		assert: (homogeneous collect: #color) asSet size equals: 1
]

{ #category : #ScatteredVocabularyPattern }
CNBPresenterTest >> testCheckAllScatteredVocabularySizeInsidePackage [

	| scatteredVocabulary packageSuffixesDictionary packages |
	scatteredVocabulary 
	:= allTokenModelsInMoose 
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
	scatteredVocabulary := allTokenModelsInMoose 
							select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isScatteredVocabulary ]  ].
							
	
	self 
		assert: (scatteredVocabulary allSatisfy: [ :each | each size >= CNBScatteredVocabularyPattern new  minClassSize ])  
		equals: true
]

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckAllSnowFlakesColorSize [

	| snowFlakes |
	snowFlakes := allTokenModelsInMoose 
							select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isSnowFlakes ]  ].
							
	
	self 
		assert: ((snowFlakes collect: #color) allSatisfy: [ :each | each isMonoClassColor ])  
		equals: true
]

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckAllSnowFlakesMaxSize [

	| snowFlakes |
	snowFlakes := allTokenModelsInMoose 
							select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isSnowFlakes ]  ].
							
	
	self 
		assert: (snowFlakes allSatisfy: [ :each | each size >= CNBSnowFlakesPattern new snowFlakesSize ])  
		equals: true
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckConfetti [

	| aTokenModel |
	aTokenModel := allTokenModelsInCalypso detect: [ :each |
		               each name = 'Example' and: [
			               each package name = 'Calypso-NavigationModel-Tests' ] ].

	aTokenModel checkConfetti.

	self
		assert:
		(aTokenModel patterns anySatisfy: [ :aPattern | aPattern isConfetti ])
		equals: true
]

{ #category : #confettiTests }
CNBPresenterTest >> testCheckConfettiNumberInCNB [

	| confetti |
	confetti := allTokenModelsInMoose select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isConfetti ]   ].
	
	self 
		assert: confetti size 
		equals: 0
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckFatBlob [

	| aTokenModel |
	aTokenModel := allTokenModelsInMoose detect: [ :each |
		               each package name = 'Moose-Algos-Graph-Tests' ].

	aTokenModel checkPatterns.

	self
		assert:
		(aTokenModel patterns anySatisfy: [ :aPattern | aPattern isFatBlob ])
		equals: true
]

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testCheckHomogeneityBreaker [

	| aTokenModel |
	aTokenModel := allTokenModelsInCalypso detect: [ :each |
		               each name = 'Strategy' and: [
			               each package name
			               = 'Calypso-SystemTools-QueryBrowser' ] ].

	aTokenModel checkPatterns.

	self
		assert: (aTokenModel patterns anySatisfy: [ :aPattern |
				 aPattern isNearlyHomogeneous ])
		equals: true
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckHomogeneous [
	| aTokenModel  |

	aTokenModel := allTokenModelsInMoose 
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
	
	aTokenModel := allTokenModelsInMoose detect: [ :each | each name = 'Command' ].
		
	aTokenModel checkPatterns.
	
	self
		assert: (aTokenModel patterns anySatisfy: [ :each | each isIntruder ]) 	
		equals: true  
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckScatteredVocabulary [
	| aTokenModel |
	
	aTokenModel := allTokenModelsInMoose 
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
	
	aTokenModel := allTokenModelsInMoose 
		detect: [ :each | each name = 'Engine' ].
	
		
	aTokenModel checkPatterns.
	
	self
		assert: (aTokenModel patterns anySatisfy: [ :each | each isSnowFlakes ] )	
		equals: true  
]

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckSnowFlakesInCNB [

	| snowFlakes actualSnowFlakes |
	snowFlakes := allTokenModelsInMoose 
							select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern  isSnowFlakes]  ].
							
	actualSnowFlakes := { 'Engine' . 'B' }.
	
	self 
		assert: (snowFlakes collect: #name) asSet equals: actualSnowFlakes asSet
]

{ #category : #confettiTests }
CNBPresenterTest >> testConfettiOutsiders [

	| confetti |
	confetti 
		:= allTokenModelsInMoose 
				select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isConfetti ] ].
	
	self 
		assert: (confetti allSatisfy: [ :each | 
						(each outsiders size <= CNBConfettiPattern new confettiPourcentage ) ])
		equals: true

	
]

{ #category : #confettiTests }
CNBPresenterTest >> testConfettiSize [

	| confetti |
	confetti := allTokenModelsInMoose select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isConfetti ]   ].
	
	self 
		assert: (confetti allSatisfy: [ :each | 
						(each belongers size >= CNBConfettiPattern new confettiSize ) ])
		equals: true

	
]

{ #category : #FatBlobTests }
CNBPresenterTest >> testFatBlobsAreNotHomogeneous [

	| fatBlobs |
	fatBlobs := allTokenModelsInMoose select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isFatBlob ]  ].

	self 
		assert: (fatBlobs anySatisfy: [ :each | each patterns anySatisfy: [ :pattern | pattern isHomogeneous ]  ])
		equals: false
]

{ #category : #FatBlobTests }
CNBPresenterTest >> testFatBlobsBelongToMultiSuffix [

	| fatBlobs |
	fatBlobs := allTokenModelsInMoose select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isFatBlob ]   ].
	
	self 
		assert: (fatBlobs allSatisfy: [ :each | each root isMultiToken ])
		equals: true
]

{ #category : #FatBlobTests }
CNBPresenterTest >> testFatBlobsSize [

	| fatBlobs |
	fatBlobs := allTokenModelsInMoose select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isFatBlob ] ].

	self 
		assert: (fatBlobs allSatisfy: [ :each | each size >= CNBFatBlobPattern new fatBlobSize ])
		equals: true
]

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testHomogeneityBreakerExists [

	| homogeneityBreakers |
	homogeneityBreakers := allTokenModelsInCalypso select: [ :each |
		                       each patterns anySatisfy: [ :aPattern |
			                       aPattern isNearlyHomogeneous ] ].

	self assert: homogeneityBreakers isNotEmpty equals: true
]

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testHomogeneityBreakerIsNotIntruder [

	| homoBreaker intruders |
	homoBreaker := allTokenModelsInMoose 
			select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isNearlyHomogeneous ] ].
	intruders := allTokenModelsInMoose 
			select: [ :each | each patterns anySatisfy: [ :pattern | pattern isIntruder ]  ].
			
	self
		assert: homoBreaker = intruders 
		equals: false
	
	
]

{ #category : #intrudersTests }
CNBPresenterTest >> testIntrudersAreNotMonoClasses [

	| intruders |
	intruders 
		:= allTokenModelsInMoose 
			select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isIntruder ]  ].
																
	self 
		assert: (intruders anySatisfy: [ :each | each root isMonoClass ])
		equals: false
]

{ #category : #intrudersTests }
CNBPresenterTest >> testIntrudersPourcentage [

	| intruders |
	intruders := allTokenModelsInMoose select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isIntruder ]  ].
																
	self 
		assert: (intruders allSatisfy: [ :each | each outsiders size <=  (each size * CNBIntruderPattern new intrudersPercentage) percent ])
		equals: true
]

{ #category : #intrudersTests }
CNBPresenterTest >> testIntrudersSizeInsideCNB [

	| intruders |
	intruders := allTokenModelsInMoose select: [ :each | each patterns anySatisfy: [ :aPattern | aPattern isIntruder ]  ].
									
	self 
		assert: intruders size
		equals: 6
]
