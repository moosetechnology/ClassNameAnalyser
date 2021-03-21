Class {
	#name : #CNBConfettiPattern,
	#superclass : #CNBAbstractPattern,
	#instVars : [
		'confettiSize',
		'confettiPourcentage',
		'minColorful'
	],
	#category : #CNBPatterns
}

{ #category : #initialization }
CNBConfettiPattern >> check: aTokenModel [

	| insideColors |
	insideColors := (aTokenModel innerRoots collect: #color) asSet.
	(
		insideColors asSet size >= self confettiSize
	)
	ifFalse: [ ^ false ].
	
	^ ((self outsidersPourcentageIn: aTokenModel) >= self confettiPourcentage) and: [ 
		(CNBBuilder new palette multiTokenColors intersection: insideColors) size >= minColorful ]
	
	
	
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
	minColorful := 2
]

{ #category : #accessing }
CNBConfettiPattern >> name [

	^ name
]

{ #category : #'as yet unclassified' }
CNBConfettiPattern >> outsidersPourcentageIn: aTokenModel [

 ^ ((aTokenModel outsiders size * 100) / aTokenModel size) asFloat.
]
