"
I am the model of the suffix of a class name (suffix is the last word in a class name written in the camel case form)
"
Class {
	#name : #CNBSuffixViewModel,
	#superclass : #CNBAbstractViewModel,
	#instVars : [
		'root',
		'classViewModels',
		'size'
	],
	#category : #CNBModels
}

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
	| classColors potentialIntrudersPercentage  potentialIntruders |
	
	classColors := classViewModels collect: #color.
	
	potentialIntruders 
		:= (classColors select: [ :each | each ~= self color ]).
	potentialIntrudersPercentage 
		:= ((potentialIntruders size * 100) / size) asFloat.
	
	(potentialIntruders anySatisfy: [ :each | each isMonoClassColor ])
		ifTrue: [ ^false ] ifFalse: [  
	 ^((potentialIntruders asSet size = 1) 
		and: 
			[ potentialIntrudersPercentage <= CNBPatternSelector intrudersPercentage ]) ]
	
	
]

{ #category : #testing }
CNBSuffixViewModel >> isFatBlob [
	| classColors |
	classColors := classViewModels collect: #color.
	(classViewModels size >= CNBPatternSelector fatBlobSize
		and: [ 
	classColors asSet size = 1
			 ])
		ifFalse: [ ^false ]
		ifTrue: [ 
			classColors atRandom 
				isMonoSuffixColor not 
			and: [ 
			classColors atRandom 
				isMonoClassColor not 
				ifTrue: [ ^true ]
				ifFalse: [ ^false ]  
				]
			 ].
		^false
]

{ #category : #testing }
CNBSuffixViewModel >> isHomogeneous [ 
	| classColors |
	classColors := classViewModels collect: #color.
	
	(classColors 
		allSatisfy: [ :aColor | 
			aColor isMonoSuffixColor ])
				ifFalse: [ ^false ]
				ifTrue: [ self color isMonoSuffixColor
						ifTrue: [ ^true ]
			 ].
		^false
]

{ #category : #testing }
CNBSuffixViewModel >> isSnowFlakes [

	| classColors |
	classColors := classViewModels collect: #color.
	^ (classColors 
			size >= CNBPatternSelector snowFlakesSize
		) and: [ 
		classColors 
			allSatisfy: [ :each | each isMonoClassColor ]
				].
]

{ #category : #accessing }
CNBSuffixViewModel >> models [
	^classViewModels 
]

{ #category : #accessing }
CNBSuffixViewModel >> root [
	^root
]

{ #category : #accessing }
CNBSuffixViewModel >> root: biggestHierarchy [
	root := biggestHierarchy
]

{ #category : #accessing }
CNBSuffixViewModel >> size [
	^size 
]
