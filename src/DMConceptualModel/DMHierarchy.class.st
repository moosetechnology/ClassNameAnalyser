Class {
	#name : #DMHierarchy,
	#superclass : #Object,
	#classVars : [
		'elements',
		'rootsANDclasses'
	],
	#category : #DMConceptualModel
}

{ #category : #adding }
DMHierarchy class >> add: anElement [
 elements add: anElement.
]

{ #category : #'as yet unclassified' }
DMHierarchy class >> allRoots [

	^rootsANDclasses collect: [ :anAssociation | anAssociation value asSet ]
]

{ #category : #accessing }
DMHierarchy class >> elements [ 
	^elements
]

{ #category : #'class initialization' }
DMHierarchy class >> initialize [ 
	super initialize.
	elements := OrderedCollection new.
	rootsANDclasses := Dictionary new
]

{ #category : #initialization }
DMHierarchy class >> initializeRoots [


	rootsANDclasses := (elements asSet collect: [ :aRoot | aRoot->Set new ]) asDictionary
]

{ #category : #'as yet unclassified' }
DMHierarchy class >> rootmodels [

	^DMBuilder buildRootModelsFrom: rootsANDclasses copy.
]

{ #category : #'as yet unclassified' }
DMHierarchy class >> rootsANDclasses [

	^rootsANDclasses
]
