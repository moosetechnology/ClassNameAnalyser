Class {
	#name : #DMClassViewModel,
	#superclass : #DMModel,
	#instVars : [
		'color',
		'root',
		'concept',
		'reference',
		'level'
	],
	#category : #DMModels
}

{ #category : #'brick-properties' }
DMClassViewModel >> borderColor [
	
	self isRoot
		ifTrue: [ ^ Color black ].
		^(Color value: color) darker 
		
]

{ #category : #accessing }
DMClassViewModel >> color [
	^ color
]

{ #category : #accessing }
DMClassViewModel >> color: aColor [
	color := aColor 
]

{ #category : #accessing }
DMClassViewModel >> concept [
	^concept
]

{ #category : #accessing }
DMClassViewModel >> concept: aClassName [
	concept := DMFeatureSelector new extractConceptFrom: aClassName
]

{ #category : #accessing }
DMClassViewModel >> height [ 
	^(1/level)*5 
]

{ #category : #testing }
DMClassViewModel >> isClassViewModel [
	^ true
]

{ #category : #testing }
DMClassViewModel >> isRoot [ 
	^self name = self rootname 
]

{ #category : #accessing }
DMClassViewModel >> label [
	^''
]

{ #category : #accessing }
DMClassViewModel >> level [
	^level 
]

{ #category : #accessing }
DMClassViewModel >> level: aLevel [
	level := aLevel
]

{ #category : #testing }
DMClassViewModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: self rootname.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
DMClassViewModel >> reference [ 
	^reference
]

{ #category : #accessing }
DMClassViewModel >> reference: aReference [

	reference := aReference
]

{ #category : #accessing }
DMClassViewModel >> root [
	^root
]

{ #category : #accessing }
DMClassViewModel >> root: aRoot [

	root := aRoot
		
]

{ #category : #'as yet unclassified' }
DMClassViewModel >> rootname [
	^ self root name
]

{ #category : #accessing }
DMClassViewModel >> width [

	^(1/level)*5 
	
]
