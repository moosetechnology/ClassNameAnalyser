Class {
	#name : #CNBSnowFlakesPattern,
	#superclass : #CNBAbstractPattern,
	#category : #'CNB-Core'
}

{ #category : #validation }
CNBSnowFlakesPattern >> check: aSuffixModel [

	^ (aSuffixModel innerRoots size 
			>= 
		CNBPatternSelector snowFlakesSize) 
			and: [ 
				aSuffixModel innerRoots 
					allSatisfy: [ :each | each isMonoClass ]
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
	name := #'Snow Flakes'
]

{ #category : #accessing }
CNBSnowFlakesPattern >> name [
	^ name
]
