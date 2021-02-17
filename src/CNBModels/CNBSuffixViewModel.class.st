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
		'isScattered'
	],
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBSuffixViewModel >> beScattered [
	isScattered := true
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
CNBSuffixViewModel >> hasIntruders [
	| potentialIntrudersPercentage  potentialIntruders |
	
	potentialIntruders := (self innerColors select: [ :each | each ~= self color ]).
	
	potentialIntrudersPercentage := ((potentialIntruders size * 100) / size) asFloat.
	
	(potentialIntruders 
		anySatisfy: [ :each | each isMonoClassColor ])
		ifTrue: [ ^false ] 
		ifFalse: [  
	 			^((potentialIntruders asSet size = 1) 
				and: 
			[ potentialIntrudersPercentage <= CNBPatternSelector intrudersPercentage ]) ]
	
	
]

{ #category : #initialization }
CNBSuffixViewModel >> initialize [ 
	super initialize.
	isScattered := false.
 
]

{ #category : #'as yet unclassified' }
CNBSuffixViewModel >> innerColors [
	
	^ classViewModels collect: #color.
]

{ #category : #testing }
CNBSuffixViewModel >> isConfetti [
	
	(self innerColors anySatisfy: [ :each | each = self color ])
	ifTrue: [ ^ false ] "or without monoClassColor >= ..."
	ifFalse: [ ^ (self innerColors asSet size >= CNBPatternSelector confettiSize) ]
	
]

{ #category : #testing }
CNBSuffixViewModel >> isFatBlob [

	(classViewModels size >= CNBPatternSelector fatBlobSize
		and: [ 
	self innerColors asSet size = 1
			 			
	])
		ifFalse: [ ^false ]
		ifTrue: [ 
			^ (self innerColors atRandom 
					isMonoSuffixColor not 
						and: [ 
						self innerColors atRandom 
							isMonoClassColor not 
				])
			 ].
]

{ #category : #testing }
CNBSuffixViewModel >> isHomogeneous [ 
	
	(self innerColors 
		allSatisfy: [ :aColor | 
			aColor isMonoSuffixColor ])
				ifFalse: [ ^ false ]
				ifTrue: [ ^ (self color isMonoSuffixColor) ].
]

{ #category : #testing }
CNBSuffixViewModel >> isScattered [
	^ isScattered 
]

{ #category : #testing }
CNBSuffixViewModel >> isSnowFlakes [

	^ (self innerColors size 
			>= 
		CNBPatternSelector snowFlakesSize) 
			and: [ 
				self innerColors 
					allSatisfy: [ :each | each isMonoClassColor ]
				].
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
