"
I am the simple model representation of a class, without visualization informations.
"
Class {
	#name : #CNBClassModel,
	#superclass : #CNBAbstractModel,
	#instVars : [
		'suffix',
		'root',
		'superclass',
		'reference',
		'prefix'
	],
	#category : #CNBModels
}

{ #category : #accessing }
CNBClassModel >> prefix [
	^prefix
]

{ #category : #accessing }
CNBClassModel >> prefix: aPrefix [
	prefix := aPrefix
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
CNBClassModel >> suffix [
	^suffix
]

{ #category : #accessing }
CNBClassModel >> suffix: aSuffix [
	suffix := aSuffix
]

{ #category : #accessing }
CNBClassModel >> superclass [
	^superclass
]

{ #category : #accessing }
CNBClassModel >> superclass: aClass [
	superclass := aClass 
]
