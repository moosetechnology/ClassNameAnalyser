Class {
	#name : #DMClassViewModel,
	#superclass : #DMModel,
	#instVars : [
		'color',
		'root',
		'concept',
		'reference',
		'height',
		'width'
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
	^25
]

{ #category : #testing }
DMClassViewModel >> isRoot [ 
	^self name = self root name 
]

{ #category : #accessing }
DMClassViewModel >> label [
	^''
]

{ #category : #testing }
DMClassViewModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: self root name.
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

{ #category : #accessing }
DMClassViewModel >> width [ 
	^25
]
