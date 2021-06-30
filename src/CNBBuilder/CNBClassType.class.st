"
I check wether the class is:
- A mono class (belong to no hierarchy and has no subclasses),
- A trait,
- A multi token (uses more than one suffix or prefix),
- A mono token (uses only one suffix or prefix).

Based on the collection of subclasses in a form of class models.
"
Class {
	#name : #CNBClassType,
	#superclass : #Object,
	#instVars : [
		'trait',
		'monoClass',
		'monoSuffix',
		'multiSuffix',
		'type'
	],
	#category : #CNBBuilder
}

{ #category : #'as yet unclassified' }
CNBClassType class >> monoClass [
	^(self new
		monoClass) type
]

{ #category : #'as yet unclassified' }
CNBClassType class >> monoToken [
	^(self new
		monoToken) type 
]

{ #category : #'as yet unclassified' }
CNBClassType class >> multiToken [
	^(self new
		multiToken) type
]

{ #category : #variables }
CNBClassType class >> trait [
	^(self new
		trait) type
]

{ #category : #variables }
CNBClassType class >> with: aCollectionOfSubClassModels [ 
	^self new
		with: aCollectionOfSubClassModels 

]

{ #category : #checking }
CNBClassType >> checkIfMonoClassWith: classModels [

	(classModels 
		hasOneElement and: [
			(classModels atRandom root name
					= 
			classModels atRandom model name)])
		
	ifTrue: [ ^ self monoClass ].
				
		^nil
]

{ #category : #checking }
CNBClassType >> checkIfMonoTokenWith: classModels [

	(classModels 
		hasMoreThanOneElement and: [ 
			classModels 
				allSatisfy: [ :each | each hasRootToken ]])
				ifTrue: [ ^ self monoToken ].
		
		^ nil
]

{ #category : #checking }
CNBClassType >> checkIfMultiToken: classModels [

	|  rootToken tokens root rootTokens mainHierarchyToken |
	root := classModels atRandom root name.
	rootTokens := CNBFeatureSelector new tokensOf: root.
	mainHierarchyToken := (classModels collect: #token) detectMax: [ :each | each  ].
	rootToken := rootTokens detect:  [ :each | each = mainHierarchyToken ] ifNone: [ rootTokens first ].
	
	tokens := (classModels collect: #token) add: rootToken; yourself.
	
	(tokens hasMoreThanOneElement) ifTrue: [ ^ self multiToken  ].
	
	^ nil 
]

{ #category : #checking }
CNBClassType >> checkIfTraitWith: 	classModels [ 
	
		(classModels 
			hasOneElement 
				and:  [ classModels first model isTrait ] ) 
						ifTrue: [ ^ self trait ] .
		^ nil
]

{ #category : #accessing }
CNBClassType >> monoClass [

	type := #monoClass
	
]

{ #category : #accessing }
CNBClassType >> monoToken [

	type := #monoToken
]

{ #category : #accessing }
CNBClassType >> multiToken [

	type := #multiToken
]

{ #category : #accessing }
CNBClassType >> trait [ 	
	
	type := #Trait
]

{ #category : #accessing }
CNBClassType >> type [ 	
	
	^ type
]

{ #category : #accessing }
CNBClassType >> with: aCollectionOfClassModels [
	
	(self checkIfTraitWith: aCollectionOfClassModels)
		ifNil: 
		[ (self checkIfMonoClassWith: aCollectionOfClassModels )
		 	ifNil: 
			[ (self checkIfMonoTokenWith: aCollectionOfClassModels) 
				ifNil: 
				[ (self checkIfMultiToken: aCollectionOfClassModels) ] ] ] 
]
