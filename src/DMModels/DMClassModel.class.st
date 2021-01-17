Class {
	#name : #DMClassModel,
	#superclass : #DMModel,
	#instVars : [
		'concept',
		'root',
		'superclass',
		'level',
		'reference'
	],
	#category : #DMModels
}

{ #category : #accessing }
DMClassModel >> concept [
	^concept
]

{ #category : #accessing }
DMClassModel >> concept: className [

	concept := DMFeatureSelector new extractConceptFrom: className
]

{ #category : #accessing }
DMClassModel >> level [
	^level
]

{ #category : #accessing }
DMClassModel >> level: aLevel [

	level := aLevel
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

{ #category : #accessing }
DMClassModel >> rootStopAt: aMothetClass [

	self level = 0
		ifTrue: [ ^ self ].
	(aMothetClass name = self name)
		ifTrue: [ ^ self ].
	self superclass isNotNil
		ifFalse: [ ^ self ].
	self superclass name = aMothetClass name
		ifTrue: [ ^ self ].
	^self superclass classmodel rootStopAt: aMothetClass
	
]

{ #category : #accessing }
DMClassModel >> superclass [
	^superclass
]

{ #category : #accessing }
DMClassModel >> superclass: aFamixClass [
	superclass := aFamixClass 
]
