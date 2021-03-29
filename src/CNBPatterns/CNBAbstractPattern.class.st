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
CNBAbstractPattern >> isHomogeneityBreaker [

	^ self name = #'Homogeneity Breaker'
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

{ #category : #'as yet unclassified' }
CNBAbstractPattern >> selectAttributedNodes: nodesCollection [
	
	| tokens tokenWithPatterns tokensToBeHighlighted nodesToBeHighlighted |
	tokens := nodesCollection select: [ :each | each model isToken ].
	tokenWithPatterns := tokens reject: [ :each | each model pattern isNil ].
	tokensToBeHighlighted := tokenWithPatterns select: [ :each | each model 
			pattern description = self description ].
	tokensToBeHighlighted do: [ :each | each model showPatternDescription ].
	nodesToBeHighlighted := (tokensToBeHighlighted union: (tokensToBeHighlighted collect: #children)).
	^ nodesToBeHighlighted flattened
	 
]
