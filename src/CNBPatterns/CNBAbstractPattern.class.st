Class {
	#name : #CNBAbstractPattern,
	#superclass : #Object,
	#instVars : [
		'description',
		'condition',
		'elements',
		'name'
	],
	#category : #CNBPatterns
}

{ #category : #accessing }
CNBAbstractPattern >> condition [
	self subclassResponsibility 
]

{ #category : #accessing }
CNBAbstractPattern >> description [
	^ description 
]

{ #category : #accessing }
CNBAbstractPattern >> elements [
	^ elements
]

{ #category : #accessing }
CNBAbstractPattern >> name [
	self subclassResponsibility 
]
