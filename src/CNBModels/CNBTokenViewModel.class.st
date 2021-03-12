"
I am the model of the suffix of a class name (suffix is the last word in a class name written in the camel case form)
"
Class {
	#name : #CNBTokenViewModel,
	#superclass : #CNBAbstractViewModel,
	#instVars : [
		'package',
		'root',
		'classViewModels',
		'size',
		'pattern',
		'position'
	],
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBTokenViewModel class >> of: aToken root: aRoot with: classes in: aPackage [

	^ (self new
		name: aToken;
		root: aRoot;
		classViewModels: classes;
		package: aPackage) create.
			
]

{ #category : #checking }
CNBTokenViewModel >> appearsInSeveralPackages [
	
	| siblings homogeneityBreakerSiblingsCheck |
	siblings := self root tokenModels  
		select: [ :each | each name = name ].
	
	homogeneityBreakerSiblingsCheck := (siblings asOrderedCollection 
		collect: [ :each | CNBHomogeneityBreakerPattern check: each ]).
	
	^ ((homogeneityBreakerSiblingsCheck occurrencesOf: true) >= CNBHomogeneityBreakerPattern new occurrences) 
	
]

{ #category : #attribution }
CNBTokenViewModel >> attributePattern [ 

	self checkPatterns.
	
]

{ #category : #accessing }
CNBTokenViewModel >> belongers [

	^ self classViewModels select: [ :each | each root = root ].
]

{ #category : #testing }
CNBTokenViewModel >> checkConfetti [
	
	| confetti |
	confetti := CNBConfettiPattern new.
	
	(confetti check: self)
		ifTrue: [ self pattern: confetti ]
	
]

{ #category : #testing }
CNBTokenViewModel >> checkFatBlob [

	| fatBlobPattern |
	fatBlobPattern := CNBFatBlobPattern new.
	
	(fatBlobPattern check: self)
			ifTrue: [ self pattern: fatBlobPattern ]
	
]

{ #category : #testing }
CNBTokenViewModel >> checkHomogeneityBreaker [

	| homogeneityBreakerPattern |
	homogeneityBreakerPattern := CNBHomogeneityBreakerPattern new.
	
	((homogeneityBreakerPattern check: self) 
		and: [ self appearsInSeveralPackages ]) ifTrue: [ self pattern: homogeneityBreakerPattern. ]
]

{ #category : #testing }
CNBTokenViewModel >> checkHomogeneous [ 
	
	| homogeneousPattern |	
	homogeneousPattern := CNBHomogeneousPattern new.
	
	(homogeneousPattern check: self)
		ifTrue: [ self pattern: homogeneousPattern ]
]

{ #category : #testing }
CNBTokenViewModel >> checkIntruder [

	| intruderPattern |
	intruderPattern := CNBIntruderPattern new.
	
	(intruderPattern check: self) 
		ifTrue: [ self pattern: intruderPattern ]
	
]

{ #category : #testing }
CNBTokenViewModel >> checkPatterns [ 

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
CNBTokenViewModel >> checkScatteredVocabulary [
	
	| scatteredVocabularyPattern |
	
	scatteredVocabularyPattern := CNBScatteredVocabularyPattern new.
	
	(size >= scatteredVocabularyPattern minClassSize)
		ifFalse: [ ^ false ].
		
	(scatteredVocabularyPattern check: self) 
		ifTrue: [ self pattern: scatteredVocabularyPattern. ]
]

{ #category : #testing }
CNBTokenViewModel >> checkSnowFlakes [

	| snowFlakesPattern |
	snowFlakesPattern := CNBSnowFlakesPattern new.
	
	(snowFlakesPattern check: self) ifTrue: [ self pattern: snowFlakesPattern. ]
]

{ #category : #accessing }
CNBTokenViewModel >> classViewModels [

	^ classViewModels  
]

{ #category : #accessing }
CNBTokenViewModel >> classViewModels: classVModels [
	classViewModels := classVModels.
]

{ #category : #operations }
CNBTokenViewModel >> create [
	
	self 
		originalColor: root color copy;
		color: root color;
		size: 	classViewModels size.
]

{ #category : #'as yet unclassified' }
CNBTokenViewModel >> dominatedBy: aRoot [
	
	^ root = aRoot
]

{ #category : #testing }
CNBTokenViewModel >> hasNoOutsiders [

	^ self belongers size = size
]

{ #category : #interactions }
CNBTokenViewModel >> hidePatternDescription [

	self box popupText: name.
	self box children do: [ :each | each model showBoxName  ]
]

{ #category : #accessing }
CNBTokenViewModel >> innerRoots [
	
	^ classViewModels collect: #root.
]

{ #category : #accessing }
CNBTokenViewModel >> outsiders [

	^ self classViewModels select: [ :each | each root ~= root ].
]

{ #category : #accessing }
CNBTokenViewModel >> outsidersRoots [
	
	^ self outsiders collect: #root
]

{ #category : #accessing }
CNBTokenViewModel >> package [

	^ package 
]

{ #category : #accessing }
CNBTokenViewModel >> package: aPackage [

	package := aPackage
]

{ #category : #accessing }
CNBTokenViewModel >> pattern [ 

	^ pattern
]

{ #category : #accessing }
CNBTokenViewModel >> pattern: aPattern [

	pattern := aPattern 
]

{ #category : #accessing }
CNBTokenViewModel >> root [

	^ root
]

{ #category : #accessing }
CNBTokenViewModel >> root: biggestHierarchy [

	root := biggestHierarchy.

]

{ #category : #interactions }
CNBTokenViewModel >> showPatternDescription [

	self box popupText: pattern description.
	self box children do: [ :each | each model hideBoxName ]
]

{ #category : #accessing }
CNBTokenViewModel >> size [

	^ size 
]

{ #category : #accessing }
CNBTokenViewModel >> size: aNumber [

	size := aNumber 
]
