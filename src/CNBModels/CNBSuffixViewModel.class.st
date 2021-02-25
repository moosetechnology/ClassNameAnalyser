"
I am the model of the suffix of a class name (suffix is the last word in a class name written in the camel case form)
"
Class {
	#name : #CNBSuffixViewModel,
	#superclass : #CNBAbstractViewModel,
	#instVars : [
		'package',
		'root',
		'classViewModels',
		'size',
		'patterns'
	],
	#category : #CNBModels
}

{ #category : #attribution }
CNBSuffixViewModel >> attributePattern [ 
	self checkPatterns.
	
]

{ #category : #'as yet unclassified' }
CNBSuffixViewModel >> belongers [
	^ self classViewModels select: [ :each | each root = root ].
]

{ #category : #testing }
CNBSuffixViewModel >> checkConfetti [
	
	| confetti |
	confetti := CNBConfettiPattern new.
	
	(confetti check: self)
		ifTrue: [ self patterns: confetti ]
	
]

{ #category : #testing }
CNBSuffixViewModel >> checkFatBlob [

	| fatBlobPattern |
	fatBlobPattern := CNBFatBlobPattern new.
	
	(fatBlobPattern check: self)
			ifTrue: [ self patterns: fatBlobPattern ]
	
]

{ #category : #testing }
CNBSuffixViewModel >> checkHomogeneityBreaker [

	| homogeneityBreakerPattern |
	homogeneityBreakerPattern := CNBHomogeneityBreakerPattern new.
	
	(homogeneityBreakerPattern check: self)
		ifTrue: [ self patterns: homogeneityBreakerPattern. ]
]

{ #category : #testing }
CNBSuffixViewModel >> checkHomogeneous [ 
	
	| homogeneousPattern |	
	homogeneousPattern := CNBHomogeneousPattern new.
	
	(homogeneousPattern check: self)
		ifTrue: [ self patterns: homogeneousPattern ]
]

{ #category : #testing }
CNBSuffixViewModel >> checkIntruder [

	| intruderPattern |
	intruderPattern := CNBIntruderPattern new.
	
	(intruderPattern check: self)
		ifTrue: [ self patterns: intruderPattern ]
	
]

{ #category : #checking }
CNBSuffixViewModel >> checkPatterns [ 
	self 
		checkFatBlob;
		checkHomogeneous;
		checkConfetti;
		checkSnowFlakes;
		checkIntruder;
		checkScatteredVocabulary.
		"checkHomogeneityBreaker".
		
]

{ #category : #testing }
CNBSuffixViewModel >> checkScatteredVocabulary [
	
	| scatteredVocabularyPattern |
	scatteredVocabularyPattern := CNBScatteredVocabularyPattern new.
	" min 3 classes per suffix"
	(self hasNoOutsiders and: [ size >= CNBPatternSelector svMinClassSize ])
		ifFalse: [ ^ false ].
	(scatteredVocabularyPattern check: self)
		ifTrue: [ self patterns: scatteredVocabularyPattern. ]
]

{ #category : #testing }
CNBSuffixViewModel >> checkSnowFlakes [

	| snowFlakesPattern |
	snowFlakesPattern := CNBSnowFlakesPattern new.
	
	(snowFlakesPattern check: self)
		ifTrue: [ self patterns: snowFlakesPattern. ]
]

{ #category : #accessing }
CNBSuffixViewModel >> classViewModels [
	^ classViewModels  
]

{ #category : #accessing }
CNBSuffixViewModel >> classViewModels: aCollectionOfClassViewModels [
	classViewModels := aCollectionOfClassViewModels.
	size := aCollectionOfClassViewModels size
]

{ #category : #testing }
CNBSuffixViewModel >> hasNoOutsiders [
	^ self belongers size = size
]

{ #category : #initialization }
CNBSuffixViewModel >> initialize [ 
	super initialize.
	patterns := OrderedCollection new.
	
 
]

{ #category : #accessing }
CNBSuffixViewModel >> innerRoots [
	
	^ classViewModels collect: #root.
]

{ #category : #accessing }
CNBSuffixViewModel >> models [
	^classViewModels 
]

{ #category : #'as yet unclassified' }
CNBSuffixViewModel >> outsiders [
	^ self classViewModels select: [ :each | each root ~= root ].
]

{ #category : #accessing }
CNBSuffixViewModel >> package [
	^package 
]

{ #category : #accessing }
CNBSuffixViewModel >> package: aPackage [
	package := aPackage
]

{ #category : #accessing }
CNBSuffixViewModel >> patterns [ 
	^ patterns
]

{ #category : #accessing }
CNBSuffixViewModel >> patterns: aPattern [
	patterns add: aPattern 
]

{ #category : #accessing }
CNBSuffixViewModel >> root [
	^root
]

{ #category : #accessing }
CNBSuffixViewModel >> root: biggestHierarchy [
	root := biggestHierarchy.

]

{ #category : #accessing }
CNBSuffixViewModel >> size [
	^size 
]
