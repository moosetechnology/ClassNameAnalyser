Class {
	#name : #DMClassViewModel,
	#superclass : #DMModel,
	#instVars : [
		'color',
		'name',
		'root'
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
	(DMHierarchy rootsANDclasses at: aRoot) add: self name.
]
