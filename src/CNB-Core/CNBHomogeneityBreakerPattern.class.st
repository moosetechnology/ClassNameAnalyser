Class {
	#name : #CNBHomogeneityBreakerPattern,
	#superclass : #CNBAbstractPattern,
	#category : #'CNB-Core'
}

{ #category : #validation }
CNBHomogeneityBreakerPattern >> check: aSuffixModel [

]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> description [
	^ description
]

{ #category : #initialization }
CNBHomogeneityBreakerPattern >> initialize [
	super initialize.
	description := 'I am a Homogeneity-Breaker'.
	name := #'Homogeneity Breaker'
]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> name [
	^ name
]
