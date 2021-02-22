Class {
	#name : #CNBConfettiPattern,
	#superclass : #CNBAbstractPattern,
	#category : #'CNB-Core'
}

{ #category : #initialization }
CNBConfettiPattern >> check: aSuffixModel [

	(aSuffixModel innerRoots anySatisfy: [ :each | each = aSuffixModel color ])
	ifTrue: [ ^ false ] "or without monoClassColor >= ..."
	ifFalse: [ ^ (aSuffixModel innerRoots asSet size >= CNBPatternSelector confettiSize) ]
	
]

{ #category : #initialization }
CNBConfettiPattern >> initialize [ 
	super initialize.
	
]
