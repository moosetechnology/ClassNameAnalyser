Class {
	#name : #CNBPatternSelector,
	#superclass : #Object,
	#instVars : [
		'cnb',
		'intrudersPercentage',
		'nbrIntrudersNeighbors',
		'fatBlobSize',
		'snowFlakesSize',
		'confettiSize',
		'svMinClassSize',
		'svMinTokenSize',
		'patternsDictionary',
		'confettiPourcentage',
		'hbMonoMinTokenSize',
		'hbMonoMaxTokenSize',
		'hbMultiPourcentage',
		'hbMultiMinTokenSize',
		'occurrences',
		'scatteredThreshold'
	],
	#category : #CNBPatterns
}

{ #category : #'as yet unclassified' }
CNBPatternSelector class >> confettiPourcentage [
	^ self new
		confettiPourcentage
]

{ #category : #accessing }
CNBPatternSelector class >> confettiSize [ 
	^ self new
		confettiSize 
]

{ #category : #'as yet unclassified' }
CNBPatternSelector class >> fatBlobSize [
	^self new
		fatBlobSize 
]

{ #category : #accessing }
CNBPatternSelector class >> hbMaxTokenSize [
	^ self new
		hbMonoMaxTokenSize
]

{ #category : #accessing }
CNBPatternSelector class >> hbMinTokenSize [
	^ self new
		hbMinTokenSize
]

{ #category : #accessing }
CNBPatternSelector class >> hbMonoMaxTokenSize [
	^ self new
		hbMonoMaxTokenSize
]

{ #category : #accessing }
CNBPatternSelector class >> hbMonoMinTokenSize [
	^ self new
		hbMonoMinTokenSize
]

{ #category : #accessing }
CNBPatternSelector class >> hbMultiMinTokenSize [ 
	^ self new
		hbMultiMinTokenSize
]

{ #category : #accessing }
CNBPatternSelector class >> hbMultiPourcentage [
	^ self new
		hbMultiPourcentage
]

{ #category : #accessing }
CNBPatternSelector class >> intrudersPercentage [ 
	^self new
		intrudersPercentage 
]

{ #category : #'as yet unclassified' }
CNBPatternSelector class >> occurrences [ 
	^ self new
		occurrences
]

{ #category : #'instance creation' }
CNBPatternSelector class >> of: aCNB [
	^ self new
		of: aCNB
]

{ #category : #accessing }
CNBPatternSelector class >> scatteredThreshold [
	^ self new
			scatteredThreshold
]

{ #category : #'as yet unclassified' }
CNBPatternSelector class >> snowFlakesSize [
	^self new
		snowFlakesSize
]

{ #category : #accessing }
CNBPatternSelector class >> svMinClassSize [
	^ self new
		svMinClassSize
]

{ #category : #'as yet unclassified' }
CNBPatternSelector class >> svMinTokenSize [
	^self new
		svMinTokenSize
]

{ #category : #accessing }
CNBPatternSelector >> confettiPourcentage [
	^ confettiPourcentage
]

{ #category : #accessing }
CNBPatternSelector >> confettiSize [ 
	^ confettiSize 
]

{ #category : #accessing }
CNBPatternSelector >> fatBlobSize [ 
	^ fatBlobSize 
]

{ #category : #accessing }
CNBPatternSelector >> hbMonoMaxTokenSize [
	^ hbMonoMaxTokenSize
]

{ #category : #accessing }
CNBPatternSelector >> hbMonoMinTokenSize [
	^ hbMonoMinTokenSize
]

{ #category : #accessing }
CNBPatternSelector >> hbMultiMinTokenSize [
	^ hbMultiMinTokenSize
]

{ #category : #accessing }
CNBPatternSelector >> hbMultiPourcentage [
	^ hbMultiPourcentage
]

{ #category : #initialization }
CNBPatternSelector >> initialize [ 
	super initialize.
	intrudersPercentage := 60.
	fatBlobSize := 7.
	snowFlakesSize := 3.
	confettiSize := 3.
	confettiPourcentage := 30. 
	svMinClassSize := 3.
	svMinTokenSize := 3.
	hbMonoMinTokenSize := 1. 
	hbMonoMaxTokenSize := 6 .
	hbMultiPourcentage := 50.
	hbMultiMinTokenSize := 3.
	occurrences := 2.
	scatteredThreshold := 10
]

{ #category : #initialization }
CNBPatternSelector >> initializePatternsDictionary [
	patternsDictionary 
		:= 
			 { #'Fat Blob' -> self selectFatBlob .
				#'Homogeneous' -> self selectHomogeneous .
				#'Confetti' -> self selectConfetti .
				#'Intruders' -> self selectIntruders .
				#'Scattered Vocabulary' -> self selectScatteredVocabulary .
				#'Snow Flakes' -> self selectSnowFlakes .
				#'Homogeneity Breaker' -> self selectHomogeneityBreaker
	 } asDictionary 
	
]

{ #category : #accessing }
CNBPatternSelector >> intrudersPercentage [
	^ intrudersPercentage 
]

{ #category : #accessing }
CNBPatternSelector >> models [
	| allModels |
	allModels := cnb viewModel packageViewModels flatCollect: #models.
	^ allModels reject: [ :each | each pattern isNil ]
]

{ #category : #accessing }
CNBPatternSelector >> nbrIntrudersNeighbors [
	^ nbrIntrudersNeighbors
]

{ #category : #accessing }
CNBPatternSelector >> occurrences [ 
	^ occurrences
]

{ #category : #'instance creation' }
CNBPatternSelector >> of: aCNB [
	cnb := aCNB.
	self initializePatternsDictionary
]

{ #category : #accessing }
CNBPatternSelector >> patternsDictionary [
	
	^ patternsDictionary 
]

{ #category : #accessing }
CNBPatternSelector >> scatteredThreshold [
	^ scatteredThreshold
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectConfetti [
	
	^ self models select: [ :each | each pattern isConfetti  ] 

	
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectFatBlob [

	^ self models select: [ :each | each pattern isFatBlob ].
	
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectHomogeneityBreaker [ 

	^ self models select: [ :each | each pattern isHomogeneityBreaker ] 

]

{ #category : #selectPatterns }
CNBPatternSelector >> selectHomogeneous [
	
	^ self models select: [ :each | each pattern isHomogeneous  ] 
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectIntruders [
	
	^ self models select: [ :each | each pattern isIntruder ]
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectPatternOf: aSymbol [

	^ patternsDictionary at: aSymbol
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectScatteredVocabulary [


	^ self models select: [ :each | each pattern isScatteredVocabulary ]
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectSnowFlakes [
	
	^ self models select: [ :each | each pattern isSnowFlakes ] 
]

{ #category : #accessing }
CNBPatternSelector >> snowFlakesSize [ 
	^ snowFlakesSize 
]

{ #category : #accessing }
CNBPatternSelector >> svMinClassSize [
	^ svMinClassSize
]

{ #category : #accessing }
CNBPatternSelector >> svMinTokenSize [
	^ svMinTokenSize
]
