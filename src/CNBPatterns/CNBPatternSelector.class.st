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
		'svMinSuffixSize',
		'patternsDictionary',
		'confettiPourcentage',
		'hbMonoMinSuffixSize',
		'hbMonoMaxSuffixSize',
		'hbMultiPourcentage',
		'hbMultiMinSuffixSize',
		'occurrences'
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
CNBPatternSelector class >> hbMaxSuffixSize [
	^ self new
		hbMonoMaxSuffixSize
]

{ #category : #accessing }
CNBPatternSelector class >> hbMinSuffixSize [
	^ self new
		hbMinSuffixSize
]

{ #category : #accessing }
CNBPatternSelector class >> hbMonoMaxSuffixSize [
	^ self new
		hbMonoMaxSuffixSize
]

{ #category : #accessing }
CNBPatternSelector class >> hbMonoMinSuffixSize [
	^ self new
		hbMonoMinSuffixSize
]

{ #category : #accessing }
CNBPatternSelector class >> hbMultiMinSuffixSize [ 
	^ self new
		hbMultiMinSuffixSize
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
CNBPatternSelector class >> svMinSuffixSize [
	^self new
		svMinSuffixSize
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
CNBPatternSelector >> hbMonoMaxSuffixSize [
	^ hbMonoMaxSuffixSize
]

{ #category : #accessing }
CNBPatternSelector >> hbMonoMinSuffixSize [
	^ hbMonoMinSuffixSize
]

{ #category : #accessing }
CNBPatternSelector >> hbMultiMinSuffixSize [
	^ hbMultiMinSuffixSize
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
	svMinSuffixSize := 3.
	hbMonoMinSuffixSize := 1. 
	hbMonoMaxSuffixSize := 6 .
	hbMultiPourcentage := 50.
	hbMultiMinSuffixSize := 3.
	occurrences := 2.
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
	^ cnb viewModel packageViewModels flatCollect: #models.
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

{ #category : #selectPatterns }
CNBPatternSelector >> selectConfetti [
	
	^ self models select: [ :each | (each patterns collect: #name) includes:  #'Confetti' ]

	
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectFatBlob [

	^ self models select: [ :each | (each patterns collect: #name) includes: #'Fat Blob'  ].
	
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectHomogeneityBreaker [ 

	^ self models select: [ :each | (each patterns collect: #name) includes: #'Homogeneity Breaker' ]

]

{ #category : #selectPatterns }
CNBPatternSelector >> selectHomogeneous [
	
	^ self models select: [ :each | (each patterns collect: #name) includes:  #'Homogeneous' ]
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectIntruders [
	
	^ self models select: [ :each | (each patterns collect: #name) includes:  #'Intruder' ]
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectPatternOf: aSymbol [

	^ patternsDictionary at: aSymbol
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectScatteredVocabulary [


	^ self models select: [ :each | (each patterns collect: #name) includes: #'Scattered Vocabulary' ]
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectSnowFlakes [
	
	^ self models select: [ :each | (each patterns collect: #name) includes:  #'Snow Flakes' ]
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
CNBPatternSelector >> svMinSuffixSize [
	^ svMinSuffixSize
]
