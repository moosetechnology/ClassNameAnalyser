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

{ #category : #testing }
DMClassViewModel >> isClassViewModel [
	^ true
]

{ #category : #accessing }
DMClassViewModel >> level [
	^level
]

{ #category : #accessing }
DMClassViewModel >> level: aLevel [
	level := aLevel
]

{ #category : #'instance creation' }
DMClassViewModel >> name: aClassName with: aColor [

	self name: aClassName.
	self color: aColor
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
