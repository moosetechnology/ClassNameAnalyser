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

{ #category : #accessing }
CNBConfettiPattern >> description [
	^ description
]

{ #category : #initialization }
CNBConfettiPattern >> initialize [ 
	super initialize.
	description := 'I am a Confetti'.
	name := #'Confetti'
]

{ #category : #accessing }
CNBConfettiPattern >> name [
	^ name
]
