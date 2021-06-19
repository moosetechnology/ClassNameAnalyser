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
		'patterns',
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

{ #category : #adding }
CNBTokenViewModel >> addPosition [ 

	(self classViewModels 
		allSatisfy: [ :aClass | 
			(CNBFeatureSelector new extract: #prefix from: aClass name) = name ])
			ifTrue: [ self name: (self name , ' (P)') ]
			ifFalse: [ 
				(self classViewModels 
					allSatisfy: [ :aClass | 
						(CNBFeatureSelector new extract: #suffix from: aClass name) = name ])
			ifTrue: [ self name: (self name , ' (S)')  ]
			ifFalse: [ self name: (self name , ' (P + S)') ]
				  ]
			
		
	
		
]

{ #category : #checking }
CNBTokenViewModel >> appearsInSeveralPackages [
	
	| siblings homogeneityBreakerSiblingsCheck mainToken |
	siblings := self root tokenModels select: [ :each | each name = name ].
"	mainToken := siblings asOrderedCollection detect: [ :each | CNBHomogeneityBreakerPattern new checkMainToken: each ]." 
	homogeneityBreakerSiblingsCheck := (siblings asOrderedCollection 
		collect: [ :each | CNBHomogeneityBreakerPattern check: each ]).
	
	^ ((homogeneityBreakerSiblingsCheck occurrencesOf: true) >= CNBHomogeneityBreakerPattern new occurrences) 
	
]

{ #category : #attribution }
CNBTokenViewModel >> attributePattern [ 

	self checkPatterns.
	
]

{ #category : #'as yet unclassified' }
CNBTokenViewModel >> attributeTokenToClasses [

	classViewModels do: [ :each | each changeTokenTo: self name ]
]

{ #category : #accessing }
CNBTokenViewModel >> belongers [

	^ self classViewModels select: [ :each | each root = root ].
]

{ #category : #'as yet unclassified' }
CNBTokenViewModel >> changeColorTo: aColor [

	self 
		originalColor: root color copy;
		color: root color.
		
	self belongers do: [ :each | each changeColorTo: aColor ]
		
]

{ #category : #'as yet unclassified' }
CNBTokenViewModel >> changeRootTo: aRoot [ 

	self 
		root: aRoot;
		color: aRoot color;
		originalColor: aRoot color
]

{ #category : #testing }
CNBTokenViewModel >> checkConfetti [
	
	| confetti |
	confetti := CNBConfettiPattern new.
	
	(confetti check: self)
		ifTrue: [ patterns add: confetti ]
	
]

{ #category : #testing }
CNBTokenViewModel >> checkFatBlob [

	| fatBlobPattern |
	fatBlobPattern := CNBFatBlobPattern new.
	
	(fatBlobPattern check: self)
			ifTrue: [ patterns add: fatBlobPattern ]
	
]

{ #category : #testing }
CNBTokenViewModel >> checkHomogeneityBreaker [

	| homogeneityBreakerPattern |
	homogeneityBreakerPattern := CNBHomogeneityBreakerPattern new.
	
	(homogeneityBreakerPattern check: self) 
		"and: [ self appearsInSeveralPackages ])" ifTrue: [ patterns add: homogeneityBreakerPattern. ]
]

{ #category : #testing }
CNBTokenViewModel >> checkHomogeneous [ 
	
	| homogeneousPattern |	
	homogeneousPattern := CNBHomogeneousPattern new.
	
	(homogeneousPattern check: self) ifTrue: [ patterns add: homogeneousPattern ]
]

{ #category : #testing }
CNBTokenViewModel >> checkIntruder [

	| intruderPattern |
	intruderPattern := CNBIntruderPattern new.
	
	(intruderPattern check: self) ifTrue: [ patterns add: intruderPattern ]
	
]

{ #category : #testing }
CNBTokenViewModel >> checkPatterns [ 

	self 
		checkHomogeneous;
		checkConfetti;
		checkSnowFlakes;
		checkIntruder;
		checkFatBlob;
		checkScatteredVocabulary;
		checkHomogeneityBreaker.
		
]

{ #category : #testing }
CNBTokenViewModel >> checkScatteredVocabulary [
	
	| scatteredVocabularyPattern |
	
	scatteredVocabularyPattern := CNBScatteredVocabularyPattern new.

	(scatteredVocabularyPattern check: self) 
]

{ #category : #testing }
CNBTokenViewModel >> checkSnowFlakes [

	| snowFlakesPattern |
	snowFlakesPattern := CNBSnowFlakesPattern new.
	
	(snowFlakesPattern check: self) ifTrue: [ patterns add: snowFlakesPattern. ]
]

{ #category : #'accessing-classes' }
CNBTokenViewModel >> classNames [ 

	^ classViewModels collect: [ :each | each name ]
]

{ #category : #accessing }
CNBTokenViewModel >> classViewModels [

	^ classViewModels  
]

{ #category : #accessing }
CNBTokenViewModel >> classViewModels: classVModels [

	classViewModels := classVModels.
]

{ #category : #accessing }
CNBTokenViewModel >> classes [ 

	^ self classViewModels 
]

{ #category : #testing }
CNBTokenViewModel >> containsHierarchy: aRoot [

	| siblingTokens |
	siblingTokens := (aRoot tokenModels select: [ :each | each name = self name ]).
	
	^ (siblingTokens flatCollect: #classViewModels)
					anySatisfy: [ :each | each root name = self root name ]
]

{ #category : #testing }
CNBTokenViewModel >> containsItsHierarchy [ 

	| siblingTokens |
	siblingTokens := (root tokenModels select: [ :each | each name = self name ]).
	
	^ (siblingTokens flatCollect: #classViewModels)
					anySatisfy: [ :each | each root name = self root name ]
]

{ #category : #operations }
CNBTokenViewModel >> create [
	
	root ifNotNil: [  
	self 
		originalColor: root color copy;
		color: root color ].
	self
		size: 	classViewModels size.
]

{ #category : #'as yet unclassified' }
CNBTokenViewModel >> dominatedBy: aRoot [
	
	^ root = aRoot
]

{ #category : #'as yet unclassified' }
CNBTokenViewModel >> dominatedBy: aRoot inside: aPackageViewModel [
	
	^ root = aRoot and: [ package name = aPackageViewModel name ]
]

{ #category : #testing }
CNBTokenViewModel >> hasNoOutsiders [

	^ self belongers size = size
]

{ #category : #interactions }
CNBTokenViewModel >> hidePatternDescription [

	self box popupText: name.
	self box children do: [ :each | each model showClassDescription  ]
]

{ #category : #initialization }
CNBTokenViewModel >> initialize [ 
	super initialize.
	
	patterns := OrderedCollection new.
	box when: RSMouseLeftClick do: [ self onClickResetHighlighter].
	box when: RSMouseRightClick do: [ self inspect].
]

{ #category : #accessing }
CNBTokenViewModel >> innerRoots [
	
	^ classViewModels collect: #root.
]

{ #category : #'as yet unclassified' }
CNBTokenViewModel >> onClickResetHighlighter [
	
	CNBSingletonHighlighter instance nodesToBeHighlighted ifEmpty: [ ^ self ].
	CNBSingletonHighlighter instance property: nil.
	CNBSingletonHighlighter instance reset.
	box topParent color: Color white darker.
]

{ #category : #accessing }
CNBTokenViewModel >> outsiders [

	^ self classViewModels select: [ :each | each root ~= root ].
]

{ #category : #'as yet unclassified' }
CNBTokenViewModel >> outsidersPercentage [ 

	^ ((self outsiders size * 100) / self size ) asFloat 
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
CNBTokenViewModel >> patterns [ 

	^ patterns
]

{ #category : #accessing }
CNBTokenViewModel >> patterns: aPattern [

	patterns add: aPattern
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
CNBTokenViewModel >> showDescriptionOf: aPattern [

	self box popupText: aPattern description.
	self box children do: [ :each | each model hideClassDescription ]
]

{ #category : #interactions }
CNBTokenViewModel >> showPatternDescription [

	self box popupText: patterns description.
	self box children do: [ :each | each model hideClassDescription ]
]

{ #category : #accessing }
CNBTokenViewModel >> size [

	^ classViewModels size 
]

{ #category : #accessing }
CNBTokenViewModel >> size: aNumber [

	size := aNumber 
]
