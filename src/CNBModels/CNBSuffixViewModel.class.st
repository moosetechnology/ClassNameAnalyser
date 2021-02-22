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
		'isScattered',
		'patterns'
	],
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBSuffixViewModel >> attributePattern [ 
	self checkPatterns.
	
]

{ #category : #'as yet unclassified' }
CNBSuffixViewModel >> beScattered [
	isScattered := true.
	
]

{ #category : #testing }
CNBSuffixViewModel >> checkFatBlob [

	| fatBlobPattern |
	fatBlobPattern := CNBFatBlobPattern new.
	(fatBlobPattern check: self)
			ifTrue: [ self patterns: fatBlobPattern ]
	
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

{ #category : #'as yet unclassified' }
CNBSuffixViewModel >> checkPatterns [ 
	self 
		checkFatBlob;
		checkHomogeneous;
		isConfetti;
		isSnowFlakes;
		checkIntruder.
		
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

{ #category : #initialization }
CNBSuffixViewModel >> initialize [ 
	super initialize.
	isScattered := false.
	patterns := OrderedCollection new.
	
 
]

{ #category : #'as yet unclassified' }
CNBSuffixViewModel >> innerRoots [
	
	^ classViewModels collect: #root.
]

{ #category : #testing }
CNBSuffixViewModel >> isConfetti [
	
	| confetti |
	confetti := CNBConfettiPattern new.
	(confetti check: self)
	ifTrue: [ self patterns: confetti ]
	
]

{ #category : #testing }
CNBSuffixViewModel >> isScattered [
	^ isScattered 
]

{ #category : #testing }
CNBSuffixViewModel >> isSnowFlakes [

	| snowFlakesPattern |
	snowFlakesPattern := CNBSnowFlakesPattern new.
	^ (snowFlakesPattern check: self)
	ifTrue: [ self patterns: snowFlakesPattern. ]
	ifFalse: [ false  ]
]

{ #category : #accessing }
CNBSuffixViewModel >> models [
	^classViewModels 
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
