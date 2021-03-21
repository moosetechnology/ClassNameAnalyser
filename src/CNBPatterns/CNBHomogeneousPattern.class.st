Class {
	#name : #CNBHomogeneousPattern,
	#superclass : #CNBAbstractPattern,
	#category : #CNBPatterns
}

{ #category : #validation }
CNBHomogeneousPattern >> check: aTokenModel [

	(aTokenModel 
		root isMonoToken)
		ifFalse: [ ^ false ].
	
	^ (aTokenModel 
			innerRoots allSatisfy: [ :aRoot | aRoot isMonoToken ])


]

{ #category : #accessing }
CNBHomogeneousPattern >> description [

	^ description
]

{ #category : #initialization }
CNBHomogeneousPattern >> initialize [
	super initialize.
	
	name := #'Homogeneous'.
	description 
	:= 
	'I am a Homogeneous suffix, 
	I am the only suffix my dominant hierarchy uses, 
	therefore my hierarchy is consistenty named.
	However, you may want to consider that other hierarchies might also be using me'
	
]

{ #category : #accessing }
CNBHomogeneousPattern >> name [

	^ name
]
