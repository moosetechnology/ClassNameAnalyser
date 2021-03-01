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
CNBClassType class >> monoSuffix [
	^(self new
		monoSuffix) type 
]

{ #category : #'as yet unclassified' }
CNBClassType class >> multiSuffix [
	^(self new
		multiSuffix) type
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
CNBClassType >> checkIfMonoClassWith: aCollectionOfClassModels [

	(aCollectionOfClassModels size = 1
 		and: [(aCollectionOfClassModels first root 
					= 
				aCollectionOfClassModels first reference)])
	ifTrue: [ ^ self monoClass ].
						
		^nil
]

{ #category : #checking }
CNBClassType >> checkIfMonoSuffixWith: aCollectionOfClassModels [
	(aCollectionOfClassModels collect: [ :each | each suffix ]) asSet
		size = 1
		&
			(aCollectionOfClassModels atRandom suffix
				=
					(CNBFeatureSelector
						extractSuffixFrom: aCollectionOfClassModels atRandom root name))
		ifTrue: [ ^ self monoSuffix ].
		^nil
]

{ #category : #checking }
CNBClassType >> checkIfMultiSuffix: aCollectionOfClassModels [

	| root rootsConcept concepts |
	root := aCollectionOfClassModels first root.
	rootsConcept := CNBFeatureSelector extractSuffixFrom: root name. 
	concepts := (aCollectionOfClassModels collect: #suffix) 
		add: rootsConcept;
		yourself.
	(concepts) size > 1
	ifTrue: [ ^self multiSuffix  ].
	^nil 
]

{ #category : #checking }
CNBClassType >> checkIfTraitWith: 	aCollectionOfClassModels [ 
	
		(aCollectionOfClassModels 
			size = 1 
				and: 
					[ aCollectionOfClassModels first reference isTrait ])
		ifTrue: [ ^ self trait ] .
		^nil
]

{ #category : #accessing }
CNBClassType >> monoClass [
	type := #monoClass
	
]

{ #category : #accessing }
CNBClassType >> monoSuffix [
	type := #monoSuffix
]

{ #category : #accessing }
CNBClassType >> multiSuffix [
	type := #multiSuffix
]

{ #category : #accessing }
CNBClassType >> trait [ 	
	type := #Trait
]

{ #category : #accessing }
CNBClassType >> type [ 	
	^type
]

{ #category : #accessing }
CNBClassType >> with: aCollectionOfClassModels [
	
	(self checkIfTraitWith: aCollectionOfClassModels)
		ifNil: 
		[ (self checkIfMonoClassWith: aCollectionOfClassModels )
		 	ifNil: 
			[ (self checkIfMonoSuffixWith: aCollectionOfClassModels) 
				ifNil: 
				[ (self checkIfMultiSuffix: aCollectionOfClassModels) ] ] ] 
]
