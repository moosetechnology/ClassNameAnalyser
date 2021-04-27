"
Pattern: I am a Homogeneous , 
	I am the only token my dominant hierarchy uses, 
	therefore my hierarchy is consistenty named.
	However, you may want to consider that other hierarchies might also be using me, 
	an indicator of such case: more than one root class in my box
"
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
	'Pattern: I am a Homogeneous , 
	I am the only token my dominant hierarchy uses, 
	therefore my hierarchy is consistenty named.
	However, you may want to consider that other hierarchies might also be using me, 
	an indicator of such case: more than one root class in my box.'
	
]

{ #category : #accessing }
CNBHomogeneousPattern >> name [

	^ name
]
