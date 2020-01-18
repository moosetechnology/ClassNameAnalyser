Class {
	#name : #DMHierarchy,
	#superclass : #Object,
	#classVars : [
		'elements'
	],
	#category : #DMConceptualModel
}

{ #category : #adding }
DMHierarchy class >> add: aFAMIXClass [ 
 elements add: aFAMIXClass.
]

{ #category : #accessing }
DMHierarchy class >> elements [ 
	^elements
]

{ #category : #'class initialization' }
DMHierarchy class >> initialize [ 
	super initialize.
	elements := OrderedCollection new
]
