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
	| classColors |
	classColors := classViewModels collect: #color.
	Number
	
	
]

{ #category : #testing }
CNBSuffixViewModel >> isFatBlob [
	| classColors |
	classColors := classViewModels collect: #color.
	(classViewModels size >= 7
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
			size >= 3
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
