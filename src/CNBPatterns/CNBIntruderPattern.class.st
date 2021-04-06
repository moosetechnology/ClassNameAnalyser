Class {
	#name : #CNBIntruderPattern,
	#superclass : #CNBAbstractPattern,
	#instVars : [
		'intrudersPercentage',
		'nbrIntrudersNeighbors'
	],
	#category : #CNBPatterns
}

{ #category : #validation }
CNBIntruderPattern >> check: aTokenModel [

	| maxIntruders |
	
	(aTokenModel root isMonoClass or: [ aTokenModel isTrait ])
		ifTrue: [ ^ false ]. "aTokenModel must belong to a monoSuffix/MultiSuffix"
	
	(aTokenModel outsiders 
		allSatisfy: [ :each | each root isMonoClass or: [ 
				each root isTrait or: [ each root isMonoToken ] ] ])
		ifTrue: [ ^ false ]. "not all outsiders are mono/traits"
	
	maxIntruders := ((self intrudersPercentage) * aTokenModel size) percent asFloat.
	 ^ (aTokenModel outsiders size <= maxIntruders ) 
	
	
	
]

{ #category : #accessing }
CNBIntruderPattern >> description [

	^ description
]

{ #category : #initialization }
CNBIntruderPattern >> initialize [
	super initialize.
	
	description 
	:= 'Anti-Pattern: Intruder; 
	I represent classes that share the same suffix with other hierarchies.
	I may point to a misconception or bad naming '.
	name := #'Intruder'.
	intrudersPercentage := 60.
]

{ #category : #accessing }
CNBIntruderPattern >> intrudersPercentage [

	^ intrudersPercentage 
]

{ #category : #accessing }
CNBIntruderPattern >> name [

	^ name
]
