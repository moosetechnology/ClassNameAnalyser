"
Superclass of all patterns.
"
Class {
	#name : #CNBAbstractPattern,
	#superclass : #Object,
	#instVars : [
		'description',
		'condition',
		'elements',
		'name'
	],
	#category : #CNBPatterns
}

{ #category : #accessing }
CNBAbstractPattern >> description [

	^ description 
]

{ #category : #accessing }
CNBAbstractPattern >> elements [

	^ elements
]

{ #category : #testing }
CNBAbstractPattern >> isConfetti [

	^ self name = #'Confetti'
]

{ #category : #testing }
CNBAbstractPattern >> isFatBlob [

	^ self name = #'Fat Blob'
]

{ #category : #testing }
CNBAbstractPattern >> isHomogeneous [ 

	^ self name = #'Homogeneous'
]

{ #category : #testing }
CNBAbstractPattern >> isIntruder [ 

	^ self name = #'Intruder'
]

{ #category : #testing }
CNBAbstractPattern >> isNearlyHomogeneous [

	^ self name = #'Nearly Homogeneous'
]

{ #category : #testing }
CNBAbstractPattern >> isPattern [ 
	^ true
]

{ #category : #testing }
CNBAbstractPattern >> isScatteredVocabulary [

	^ self name = #'Scattered Vocabulary'
]

{ #category : #testing }
CNBAbstractPattern >> isSnowFlakes [ 

	^ self name = #'Snow Flakes'
]

{ #category : #accessing }
CNBAbstractPattern >> name [

	self subclassResponsibility 
]

{ #category : #'accessing selection' }
CNBAbstractPattern >> selectAttributedNodes: nodesCollection [
	
	| tokens tokenWithPatterns tokensToBeHighlighted nodesToBeHighlighted |
	CNBSingletonHighlighter instance property: nil.
	tokens 
		:= nodesCollection select: [ :each | each model isToken ].
		
	tokenWithPatterns 
		:= tokens reject: [ :each | each model patterns isEmpty ].
		
	tokensToBeHighlighted 
		:= tokenWithPatterns 
				select: [ :each | (each model patterns collect: #name) includes: self name ].
				
	"tokensToBeHighlighted 
		do: [ :each | each model showDescriptionOf: self ]."
		
	nodesToBeHighlighted 
		:= (tokensToBeHighlighted union: (tokensToBeHighlighted collect: #children)).
	^ nodesToBeHighlighted flattened
	 
]
