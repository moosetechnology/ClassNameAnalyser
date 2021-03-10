Class {
	#name : #CNBHomogeneousPattern,
	#superclass : #CNBAbstractPattern,
	#category : #CNBPatterns
}

{ #category : #validation }
CNBHomogeneousPattern >> check: aSuffixModel [

	(aSuffixModel root isMonoToken)
	ifFalse: [ ^ false ].
	
	^ (aSuffixModel innerRoots allSatisfy: [ :aRoot | aRoot isMonoToken ])


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
