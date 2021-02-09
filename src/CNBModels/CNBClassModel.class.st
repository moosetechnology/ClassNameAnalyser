"
I am the simple model representation of a class, without visualization informations.
"
Class {
	#name : #CNBClassModel,
	#superclass : #CNBAbstractModel,
	#instVars : [
		'concept',
		'root',
		'superclass',
		'reference'
	],
	#category : #CNBModels
}

{ #category : #accessing }
CNBClassModel >> concept [
	^concept
]

{ #category : #accessing }
CNBClassModel >> concept: className [

	concept := DMFeatureSelector new extractConceptFrom: className
]

{ #category : #printing }
CNBClassModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
CNBClassModel >> reference [
	^reference
]

{ #category : #accessing }
CNBClassModel >> reference: aReference [

	reference := aReference
]

{ #category : #accessing }
CNBClassModel >> root [
	^root
	
]

{ #category : #accessing }
CNBClassModel >> root: aRoot [
	root := aRoot.
]

{ #category : #accessing }
CNBClassModel >> rootAccordingTo: aMotherClass [
	self root: (reference rootAccordingTo: aMotherClass).
	^self root
]

{ #category : #accessing }
CNBClassModel >> superclass [
	^superclass
]

{ #category : #accessing }
CNBClassModel >> superclass: aClass [
	superclass := aClass 
]
