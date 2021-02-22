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

{ #category : #accessing }
CNBHomogeneousPattern >> description [
	^ description
]

{ #category : #initialization }
CNBHomogeneousPattern >> initialize [
	super initialize.
	description := 'I am a Homogeneous'.
	name := #'Homogeneous'
]

{ #category : #accessing }
CNBHomogeneousPattern >> name [
	^ name
]
