Class {
	#name : #CNBConfettiPattern,
	#superclass : #CNBAbstractPattern,
	#instVars : [
		'confettiSize',
		'confettiPourcentage'
	],
	#category : #CNBPatterns
}

{ #category : #initialization }
CNBConfettiPattern >> check: aTokenModel [

	| outsidersPourcentage |
	
	(
		(aTokenModel innerRoots collect: #color)
			asSet size >= self confettiSize
	)
	ifFalse: [ ^ false ].
	
	
	outsidersPourcentage := ((aTokenModel outsiders size * 100) / aTokenModel size) asFloat.
	
	^ (outsidersPourcentage >= self confettiPourcentage)
	
	
	
]

{ #category : #accessing }
CNBConfettiPattern >> confettiPourcentage [

	^ confettiPourcentage
]

{ #category : #accessing }
CNBConfettiPattern >> confettiSize [ 

	^ confettiSize 
]

{ #category : #accessing }
CNBConfettiPattern >> description [

	^ description
]

{ #category : #initialization }
CNBConfettiPattern >> initialize [ 
	super initialize.
	
	description 
	:= 
	'I am a Confetti, as my name indicates, 
	many hierarchies use this suffix, 
	therefore I represent an anti-pattern'.
	
	name := #'Confetti'.
	confettiSize := 3.
	confettiPourcentage := 30. 
]

{ #category : #accessing }
CNBConfettiPattern >> name [

	^ name
]
