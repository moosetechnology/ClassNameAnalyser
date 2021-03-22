Class {
	#name : #CNBSnowFlakesPattern,
	#superclass : #CNBAbstractPattern,
	#instVars : [
		'snowFlakesSize'
	],
	#category : #CNBPatterns
}

{ #category : #validation }
CNBSnowFlakesPattern >> check: aTokenModel [

	^ (aTokenModel innerRoots size >= self snowFlakesSize) 
			and: [ 
		aTokenModel innerRoots allSatisfy: [ :each | each isMonoClass or: [ each isTrait ] ] 
					].
]

{ #category : #accessing }
CNBSnowFlakesPattern >> description [

	^ description
]

{ #category : #initialization }
CNBSnowFlakesPattern >> initialize [
	super initialize.
	
	description := 
	'Anti-Pattern: Snow flakes; my classes fall independently from hierarchies. 
	I represent  traits and solo classes that belong to no hierarchy. 
	However, you may want to check my mono classes in case of a missed oppurtunity to group them into a single hierarchy'.
	name := #'Snow Flakes'.
	snowFlakesSize := 3.
]

{ #category : #accessing }
CNBSnowFlakesPattern >> name [

	^ name
]

{ #category : #accessing }
CNBSnowFlakesPattern >> snowFlakesSize [ 

	^ snowFlakesSize 
]
