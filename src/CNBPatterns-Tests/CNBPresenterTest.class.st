Class {
	#name : #CNBPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'allTokenModelsInMoose',
		'allTokenModelsInCommander'
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
	allTokenModelsInCommander := self allNonEmptyTokensInPackagesMatching:
		                           'Commander-*'
]

{ #category : #checkPatternsInCNB }
CNBPresenterTest >> testCheckAllHomogeneous [

	| homogeneous |
	homogeneous := allTokenModelsInMoose select: [ :each |
		               each patterns anySatisfy: [ :aPattern |
			               aPattern isHomogeneous ] ].

	self assert: (homogeneous collect: #color) asSet size equals: 1
]

{ #category : #checkPatternsInCNB }
CNBPresenterTest >> testCheckAllHomogeneousColorSize [

	| homogeneous |
	homogeneous := allTokenModelsInMoose select: [ :each |
		               each patterns anySatisfy: [ :aPattern |
			               aPattern isHomogeneous ] ].

	self assert: (homogeneous collect: #color) asSet size equals: 1
]

{ #category : #ScatteredVocabularyPattern }
CNBPresenterTest >> testCheckAllScatteredVocabularySizeInsidePackage [

	| scatteredVocabulary packageSuffixes packages |
	scatteredVocabulary := allTokenModelsInMoose select: [ :each |
		                       each patterns anySatisfy:
			                       #isScatteredVocabulary ].

	packages := scatteredVocabulary collectAsSet: [ :each | each package ].
	packageSuffixes := packages flatCollect: [ :each |
		                             scatteredVocabulary select: [ :suffix |
			                             suffix package = each ] ].

	self assert: (packageSuffixes allSatisfy: [ :each |
			 each size >= CNBScatteredVocabularyPattern new minTokenSize ])
]

{ #category : #ScatteredVocabularyPattern }
CNBPresenterTest >> testCheckAllScatteredVocabularySuffixSize [

	| scatteredVocabulary |
	scatteredVocabulary := allTokenModelsInMoose select: [ :each |
		                       each patterns anySatisfy: [ :aPattern |
			                       aPattern isScatteredVocabulary ] ].

	self assert: (scatteredVocabulary allSatisfy: [ :each |
			 each size >= CNBScatteredVocabularyPattern new minClassSize ])
]

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckAllSnowFlakesColorSize [

	| snowFlakes |
	snowFlakes := allTokenModelsInMoose select: [ :each |
		              each patterns anySatisfy: [ :aPattern |
			              aPattern isSnowFlakes ] ].

	self assert: ((snowFlakes collect: #color) allSatisfy: [ :each |
			 each isMonoClassColor ])
]

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckAllSnowFlakesMaxSize [

	| snowFlakes |
	snowFlakes := allTokenModelsInMoose select: [ :each |
		              each patterns anySatisfy: [ :aPattern |
			              aPattern isSnowFlakes ] ].

	self assert: (snowFlakes allSatisfy: [ :each |
			 each size >= CNBSnowFlakesPattern new snowFlakesSize ])
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckConfetti [

	| aTokenModel |
	aTokenModel := allTokenModelsInCommander detect: [ :each |
		               each name = 'Example' and: [
			               each package name = 'Commander-Core-Tests' ] ].

	aTokenModel checkConfetti.

	self assert:
		(aTokenModel patterns anySatisfy: [ :aPattern | aPattern isConfetti ])
]

{ #category : #confettiTests }
CNBPresenterTest >> testCheckConfettiNumberInCNB [

	| confetti |
	confetti := allTokenModelsInMoose select: [ :each |
		            each patterns anySatisfy: [ :aPattern |
			            aPattern isConfetti ] ].

	self assertEmpty: confetti
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckFatBlob [

	| aTokenModel |
	aTokenModel := allTokenModelsInMoose detect: [ :each |
		               each name = 'Command' ].

	aTokenModel checkPatterns.

	self assert:
		(aTokenModel patterns anySatisfy: [ :aPattern | aPattern isFatBlob ])
]

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testCheckHomogeneityBreaker [

	| aTokenModel |
	aTokenModel := allTokenModelsInCommander detect: [ :each |
		               each name = 'Context' and: [
			               each package name = 'Commander-Core' ] ].

	aTokenModel checkPatterns.

	self assert: (aTokenModel patterns anySatisfy: [ :aPattern |
			 aPattern isNearlyHomogeneous ])
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckHomogeneous [

	| aTokenModel |
	aTokenModel := allTokenModelsInMoose detect: [ :each |
		               each name = 'Strategy' and: [
			               each package name = 'Moose-Query' ] ].

	aTokenModel checkPatterns.
	self assert:
		(aTokenModel patterns anySatisfy: [ :each | each isHomogeneous ])
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckIntruder [

	| aTokenModel |
	aTokenModel := allTokenModelsInMoose detect: [ :each |
		               each name = 'Query' ].

	aTokenModel checkPatterns.

	self assert:
		(aTokenModel patterns anySatisfy: [ :each | each isIntruder ])
]

{ #category : #checkingOneSuffixPattern }
CNBPresenterTest >> testCheckScatteredVocabulary [

	| aTokenModel |
	aTokenModel := allTokenModelsInMoose detect: [ :each |
		               each name = 'Task' and: [
			               each package name = 'Moose-SmalltalkImporter' ] ].

	aTokenModel root checkScatteredVocabulary.

	self assert: (aTokenModel patterns anySatisfy: [ :aPattern |
			 aPattern isScatteredVocabulary ])
]

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckSnowFlakes [

	| aTokenModel |
	aTokenModel := allTokenModelsInMoose detect: [ :each |
		               each name = 'B' ].

	aTokenModel checkPatterns.

	self assert:
		(aTokenModel patterns anySatisfy: [ :each | each isSnowFlakes ])
]

{ #category : #SnowFlakesTest }
CNBPresenterTest >> testCheckSnowFlakesInCNB [

	| snowFlakes |
	snowFlakes := allTokenModelsInMoose select: [ :each |
		              each patterns anySatisfy: [ :aPattern |
			              aPattern isSnowFlakes ] ].

	self
		assertCollection: (snowFlakes collect: #name) asSet
		hasSameElements: { 'B' }
]

{ #category : #confettiTests }
CNBPresenterTest >> testConfettiOutsiders [

	| confetti |
	confetti := allTokenModelsInMoose select: [ :each |
		            each patterns anySatisfy: [ :aPattern |
			            aPattern isConfetti ] ].

	self assert: (confetti allSatisfy: [ :each |
			 each outsiders size <= CNBConfettiPattern new confettiPourcentage ])
]

{ #category : #confettiTests }
CNBPresenterTest >> testConfettiSize [

	| confetti |
	confetti := allTokenModelsInMoose select: [ :each |
		            each patterns anySatisfy: [ :aPattern |
			            aPattern isConfetti ] ].

	self assert: (confetti allSatisfy: [ :each |
			 each belongers size >= CNBConfettiPattern new confettiSize ])
]

{ #category : #FatBlobTests }
CNBPresenterTest >> testFatBlobsAreNotHomogeneous [

	| fatBlobs |
	fatBlobs := allTokenModelsInMoose select: [ :each |
		            each patterns anySatisfy: [ :aPattern |
			            aPattern isFatBlob ] ].

	self deny: (fatBlobs anySatisfy: [ :each |
			 each patterns anySatisfy: #isHomogeneous ])
]

{ #category : #FatBlobTests }
CNBPresenterTest >> testFatBlobsBelongToMultiSuffix [

	| fatBlobs |
	fatBlobs := allTokenModelsInMoose select: [ :each |
		            each patterns anySatisfy: [ :aPattern |
			            aPattern isFatBlob ] ].

	self assert:
		(fatBlobs allSatisfy: [ :each | each root isMultiToken ])
]

{ #category : #FatBlobTests }
CNBPresenterTest >> testFatBlobsSize [

	| fatBlobs |
	fatBlobs := allTokenModelsInMoose select: [ :each |
		            each patterns anySatisfy: [ :aPattern |
			            aPattern isFatBlob ] ].

	self assert: (fatBlobs allSatisfy: [ :each |
			 each size >= CNBFatBlobPattern new fatBlobSize ])
]

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testHomogeneityBreakerExists [

	| homogeneityBreakers |
	homogeneityBreakers := allTokenModelsInCommander select: [ :each |
		                       each patterns anySatisfy: [ :aPattern |
			                       aPattern isNearlyHomogeneous ] ].

	self assert: homogeneityBreakers isNotEmpty
]

{ #category : #HomogeneityBreakerTests }
CNBPresenterTest >> testHomogeneityBreakerIsNotIntruder [

	| homoBreaker intruders |
	homoBreaker := allTokenModelsInMoose select: [ :each |
		               each patterns anySatisfy: [ :aPattern |
			               aPattern isNearlyHomogeneous ] ].
	intruders := allTokenModelsInMoose select: [ :each |
		             each patterns anySatisfy: [ :pattern |
			             pattern isIntruder ] ].

	self deny: homoBreaker equals: intruders
]

{ #category : #intrudersTests }
CNBPresenterTest >> testIntrudersAreNotMonoClasses [

	| intruders |
	intruders := allTokenModelsInMoose select: [ :each |
		             each patterns anySatisfy: [ :aPattern |
			             aPattern isIntruder ] ].

	self assert:
		(intruders noneSatisfy: [ :each | each root isMonoClass ])
]

{ #category : #intrudersTests }
CNBPresenterTest >> testIntrudersPourcentage [

	| intruders |
	intruders := allTokenModelsInMoose select: [ :each |
		             each patterns anySatisfy: [ :aPattern |
			             aPattern isIntruder ] ].

	self assert: (intruders allSatisfy: [ :each |
			 each outsiders size
			 <=
			 (each size * CNBIntruderPattern new intrudersPercentage) percent ])
]

{ #category : #intrudersTests }
CNBPresenterTest >> testIntrudersSizeInsideCNB [

	| intruders |
	intruders := allTokenModelsInMoose select: [ :each |
		             each patterns anySatisfy: [ :aPattern |
			             aPattern isIntruder ] ].

	self assert: intruders size equals: 1
]
