Class {
	#name : #CNBHomogeneousPattern,
	#superclass : #CNBAbstractPattern,
	#category : #'CNB-Core'
}

{ #category : #validation }
CNBHomogeneousPattern >> check: aSuffixModel [

	^ (aSuffixModel root isMonoSuffix)
	ifFalse: [ false ]
	ifTrue: [ (aSuffixModel innerRoots allSatisfy: [ :aRoot | aRoot isMonoSuffix ]) ]


]
