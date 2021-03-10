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
	
	description := 'I am a Snow Flakes'.
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
