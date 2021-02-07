"
I am the simple model representation of a class, without visualization informations.
"
Class {
	#name : #DMClassModel,
	#superclass : #DMModel,
	#instVars : [
		'concept',
		'root',
		'superclass',
		'reference'
	],
	#category : #CNBModels
}

{ #category : #accessing }
DMClassModel >> concept [
	^concept
]

{ #category : #accessing }
DMClassModel >> concept: className [

	concept := DMFeatureSelector new extractConceptFrom: className
]

{ #category : #printing }
DMClassModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
DMClassModel >> reference [
	^reference
]

{ #category : #accessing }
DMClassModel >> reference: aReference [

	reference := aReference
]

{ #category : #accessing }
DMClassModel >> root [
	^root
	
]

{ #category : #accessing }
DMClassModel >> root: aRoot [
	root := aRoot.
]

{ #category : #'as yet unclassified' }
DMClassModel >> rootAccordingTo: aMotherClass [
	self root: (reference rootAccordingTo: aMotherClass).
	^self root
]

{ #category : #accessing }
DMClassModel >> superclass [
	^superclass
]

{ #category : #accessing }
DMClassModel >> superclass: aClass [
	superclass := aClass 
]
