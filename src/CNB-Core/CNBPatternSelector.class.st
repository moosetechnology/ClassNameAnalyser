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
		'patternsDictionary'
	],
	#category : #'CNB-Core'
}

{ #category : #accessing }
CNBPatternSelector class >> confettiSize [ 
	^self new
		confettiSize 
]

{ #category : #'as yet unclassified' }
CNBPatternSelector class >> fatBlobSize [
	^self new
		fatBlobSize 
]

{ #category : #accessing }
CNBPatternSelector class >> intrudersPercentage [ 
	^self new
		intrudersPercentage 
]

{ #category : #'as yet unclassified' }
CNBPatternSelector class >> nbrIntrudersNeighbors [
	^self new
		nbrIntrudersNeighbors
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
CNBPatternSelector >> confettiSize [ 
	^ confettiSize 
]

{ #category : #accessing }
CNBPatternSelector >> fatBlobSize [ 
	^ fatBlobSize 
]

{ #category : #initialization }
CNBPatternSelector >> initialize [ 
	super initialize.
	intrudersPercentage := 50.
	fatBlobSize := 7.
	snowFlakesSize := 3.
	confettiSize := 3.
	svMinClassSize := 3.
	svMinSuffixSize := 3.
	nbrIntrudersNeighbors := 3
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
				
	 } asDictionary 
	"#'Homogeneity Breaker' -> self selectHomogeneityBreaker"
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

	cnb rootModels do: [ :each | each hasScatteredVocabulary ].
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
