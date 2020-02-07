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

{ #category : #'as yet unclassified' }
DMClassViewModel >> classmodel [

	^DMClassModel new
	name: self name;
	root: self root;
	level: self level;
	reference: self reference;
	concept: self name.
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
DMClassViewModel >> concept: aName [

	concept := DMFeatureSelector new extractConceptFrom: aName.
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

	root := aRoot.
	(DMHierarchy rootsANDclasses at: aRoot) add: self classmodel
]
