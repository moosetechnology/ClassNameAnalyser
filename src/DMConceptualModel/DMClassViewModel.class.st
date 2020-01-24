Class {
	#name : #DMClassViewModel,
	#superclass : #DMModel,
	#instVars : [
		'color',
		'name',
		'root',
		'concept'
	],
	#category : #DMConceptualModel
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
DMClassViewModel >> concept: aName [

	concept := DMFeatureSelector new extractConceptFrom: aName.
]

{ #category : #accessing }
DMClassViewModel >> name [
	^name
]

{ #category : #accessing }
DMClassViewModel >> name: aClassName [
	name := aClassName.
	

]

{ #category : #'instance creation' }
DMClassViewModel >> name: aClassName with: aColor [

	self name: aClassName.
	self color: aColor
]

{ #category : #accessing }
DMClassViewModel >> root [ 
	^root
]

{ #category : #accessing }
DMClassViewModel >> root: aRoot [

	root := aRoot.
	(DMHierarchy rootsANDclasses at: aRoot) add: self.
]
