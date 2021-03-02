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
		'pattern'
	],
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBSuffixViewModel >> appearsInSeveralPackages [
	
	| siblings homogeneityBreakerSiblingsCheck |
	siblings := self root concepts 
		select: [ :each | each name = name ].
	
	homogeneityBreakerSiblingsCheck := (siblings asOrderedCollection 
		collect: [ :each | CNBHomogeneityBreakerPattern check: each ]).
	
	^ ((homogeneityBreakerSiblingsCheck occurrencesOf: true) >= CNBPatternSelector occurrences) 
	
]

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
		ifTrue: [ self pattern: confetti ]
	
]

{ #category : #testing }
CNBSuffixViewModel >> checkFatBlob [

	| fatBlobPattern |
	fatBlobPattern := CNBFatBlobPattern new.
	
	(fatBlobPattern check: self)
			ifTrue: [ self pattern: fatBlobPattern ]
	
]

{ #category : #testing }
CNBSuffixViewModel >> checkHomogeneityBreaker [

	| homogeneityBreakerPattern |
	homogeneityBreakerPattern := CNBHomogeneityBreakerPattern new.
	
	((homogeneityBreakerPattern check: self) 
		and: [ self appearsInSeveralPackages ]) ifTrue: [ self pattern: homogeneityBreakerPattern. ]
]

{ #category : #testing }
CNBSuffixViewModel >> checkHomogeneous [ 
	
	| homogeneousPattern |	
	homogeneousPattern := CNBHomogeneousPattern new.
	
	(homogeneousPattern check: self)
		ifTrue: [ self pattern: homogeneousPattern ]
]

{ #category : #testing }
CNBSuffixViewModel >> checkIntruder [

	| intruderPattern |
	intruderPattern := CNBIntruderPattern new.
	
	(intruderPattern check: self) 
		ifTrue: [ self pattern: intruderPattern ]
	
]

{ #category : #checking }
CNBSuffixViewModel >> checkPatterns [ 
	self 
		checkFatBlob;
		checkHomogeneous;
		checkConfetti;
		checkSnowFlakes;
		checkIntruder;
		checkScatteredVocabulary;
		checkHomogeneityBreaker.
		
]

{ #category : #testing }
CNBSuffixViewModel >> checkScatteredVocabulary [
	
	| scatteredVocabularyPattern |
	
	scatteredVocabularyPattern := CNBScatteredVocabularyPattern new.
	
	(self hasNoOutsiders and: [ size >= CNBPatternSelector svMinClassSize ])
		ifFalse: [ ^ false ].
		
	(scatteredVocabularyPattern check: self) 
		ifTrue: [ self pattern: scatteredVocabularyPattern. ]
]

{ #category : #testing }
CNBSuffixViewModel >> checkSnowFlakes [

	| snowFlakesPattern |
	snowFlakesPattern := CNBSnowFlakesPattern new.
	
	(snowFlakesPattern check: self) ifTrue: [ self pattern: snowFlakesPattern. ]
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

{ #category : #'as yet unclassified' }
CNBSuffixViewModel >> hidePatternDescription [
	self box popupText: name.
	self box children do: [ :each | each model showBoxName  ]
]

{ #category : #initialization }
CNBSuffixViewModel >> initialize [ 
	super initialize.
	
	
 
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
CNBSuffixViewModel >> pattern [ 
	^ pattern
]

{ #category : #accessing }
CNBSuffixViewModel >> pattern: aPattern [
	pattern := aPattern 
]

{ #category : #accessing }
CNBSuffixViewModel >> root [
	^root
]

{ #category : #accessing }
CNBSuffixViewModel >> root: biggestHierarchy [
	root := biggestHierarchy.

]

{ #category : #'as yet unclassified' }
CNBSuffixViewModel >> showPatternDescription [
	self box popupText: pattern description.
	self box children do: [ :each | each model hideBoxName ]
]

{ #category : #accessing }
CNBSuffixViewModel >> size [
	^size 
]
