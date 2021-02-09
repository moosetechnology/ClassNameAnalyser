Class {
	#name : #DMClassType,
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
DMClassType class >> monoClass [
	^(self new
		monoClass) type
]

{ #category : #'as yet unclassified' }
DMClassType class >> monoSuffix [
	^(self new
		monoSuffix) type 
]

{ #category : #'as yet unclassified' }
DMClassType class >> multiSuffix [
	^(self new
		multiSuffix) type
]

{ #category : #variables }
DMClassType class >> trait [
	^(self new
		trait) type
]

{ #category : #variables }
DMClassType class >> with: aCollectionOfSubClassModels [ 
	^self new
		with: aCollectionOfSubClassModels 

]

{ #category : #checking }
DMClassType >> checkIfMonoClassWith: aCollectionOfClassModels [

	(aCollectionOfClassModels size = 1
 		and: [(aCollectionOfClassModels first root 
					= 
				aCollectionOfClassModels first reference)])
	ifTrue: [ ^ self monoClass ].
						
		^nil
]

{ #category : #checking }
DMClassType >> checkIfMonoSuffixWith: aCollectionOfClassModels [
	(aCollectionOfClassModels collect: [ :each | each concept ]) asSet
		size = 1
		&
			(aCollectionOfClassModels atRandom concept
				=
					(DMFeatureSelector
						extractConceptFrom: aCollectionOfClassModels atRandom root name))
		ifTrue: [ ^ self monoSuffix ].
		^nil
]

{ #category : #checking }
DMClassType >> checkIfMultiSuffix: aCollectionOfClassModels [

	| root rootsConcept concepts |
	root := aCollectionOfClassModels first root.
	rootsConcept := DMFeatureSelector extractConceptFrom: root name. 
	concepts := (aCollectionOfClassModels collect: #concept) 
		add: rootsConcept;
		yourself.
	(concepts) size > 1
	ifTrue: [ ^self multiSuffix  ].
	^nil 
]

{ #category : #checking }
DMClassType >> checkIfTraitWith: 	aCollectionOfClassModels [ 
	
		(aCollectionOfClassModels 
			size = 1 
				and: 
					[ aCollectionOfClassModels first reference isTrait ])
		ifTrue: [ ^ self trait ] .
		^nil
]

{ #category : #accessing }
DMClassType >> monoClass [
	type := #monoClass
	
]

{ #category : #accessing }
DMClassType >> monoSuffix [
	type := #monoSuffix
]

{ #category : #accessing }
DMClassType >> multiSuffix [
	type := #multiSuffix
]

{ #category : #accessing }
DMClassType >> trait [ 	
	type := #trait
]

{ #category : #accessing }
DMClassType >> type [ 	
	^type
]

{ #category : #accessing }
DMClassType >> with: aCollectionOfClassModels [
	
	(self checkIfTraitWith: aCollectionOfClassModels)
		ifNil: 
		[ (self checkIfMonoClassWith: aCollectionOfClassModels )
		 	ifNil: 
			[ (self checkIfMonoSuffixWith: aCollectionOfClassModels) 
				ifNil: 
				[ (self checkIfMultiSuffix: aCollectionOfClassModels) ] ] ] 
]
