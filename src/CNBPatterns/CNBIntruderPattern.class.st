Class {
	#name : #CNBIntruderPattern,
	#superclass : #CNBAbstractPattern,
	#category : #CNBPatterns
}

{ #category : #validation }
CNBIntruderPattern >> check: aSuffixModel [

	| maxIntruders |
	
	(aSuffixModel root isMonoClass or: [ aSuffixModel isTrait ])
		ifTrue: [ ^ false ]. "aSuffixModel must belong to a monoSuffix/MultiSuffix"
	
	(aSuffixModel outsiders allSatisfy: [ :each | each root isMonoClass or: [ each root isTrait ] ])
		ifTrue: [ ^ false ]. "not all outsiders are mono/traits"
	
	maxIntruders := ((CNBPatternSelector intrudersPercentage) * aSuffixModel size) percent asFloat.
	 ^ (aSuffixModel outsiders size <= maxIntruders ) 
	
	
	
]

{ #category : #accessing }
CNBIntruderPattern >> description [
	^ description
]

{ #category : #initialization }
CNBIntruderPattern >> initialize [
	super initialize.
	description := 'I am a Intruder'.
	name := #'Intruder'
]

{ #category : #accessing }
CNBIntruderPattern >> name [
	^ name
]
