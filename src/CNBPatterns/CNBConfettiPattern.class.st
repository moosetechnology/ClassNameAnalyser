Class {
	#name : #CNBConfettiPattern,
	#superclass : #CNBAbstractPattern,
	#category : #CNBPatterns
}

{ #category : #initialization }
CNBConfettiPattern >> check: aSuffixModel [

	| outsidersPourcentage |
	
	(
		(aSuffixModel innerRoots collect: #color)
			asSet size >= CNBPatternSelector confettiSize
	)
	ifFalse: [ ^ false ].
	
	
	outsidersPourcentage := ((aSuffixModel outsiders size * 100) / aSuffixModel size) asFloat.
	
	^ (outsidersPourcentage >= CNBPatternSelector confettiPourcentage)
	
	
	
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
