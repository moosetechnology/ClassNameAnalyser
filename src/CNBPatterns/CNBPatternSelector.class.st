Class {
	#name : #CNBPatternSelector,
	#superclass : #Object,
	#instVars : [
		'cnb',
		'patternsDictionary',
		'confettiPourcentage',
		'occurrences',
		'scatteredThreshold'
	],
	#category : #CNBPatterns
}

{ #category : #'instance creation' }
CNBPatternSelector class >> of: aCNB [
	^ self new
		of: aCNB
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
CNBPatternSelector >> models [

	 ^ (cnb 
			viewModel 
				packageViewModels 
					flatCollect: #tokenViewModels)
	 					reject: [ :each | each pattern isNil ]
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
	
	^ self models select: [ :each | each pattern isConfetti  ] 

	
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectFatBlob [

	^ self models select: [ :each | each pattern isFatBlob ].
	
]

{ #category : #selectPatterns }
CNBPatternSelector >> selectHomogeneityBreaker [ 

	^ self models select: [ :each | each pattern isNearlyHomogeneous ] 

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
