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

{ #category : #initialization }
CNBSnowFlakesPattern >> initialize [
	super initialize.
]
