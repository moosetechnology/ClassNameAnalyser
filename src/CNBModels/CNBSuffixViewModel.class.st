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
CNBSuffixViewModel >> isHomogeneous [ 
	| classColors |
	classColors := classViewModels collect: #color.
	
	(classColors 
		allSatisfy: [ :aColor | 
			aColor isMonoSuffixColor ])
				ifFalse: [ ^false ]
				ifTrue: [ self color isMonoSuffixColor
						ifTrue: [ ^true ]
			 ]
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
