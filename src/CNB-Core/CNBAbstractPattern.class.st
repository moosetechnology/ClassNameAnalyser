Class {
	#name : #CNBAbstractPattern,
	#superclass : #Object,
	#instVars : [
		'description',
		'condition',
		'elements'
	],
	#category : #'CNB-Core'
}

{ #category : #accessing }
CNBAbstractPattern >> condition [
	self subclassResponsibility 
]

{ #category : #accessing }
CNBAbstractPattern >> description [
	self subclassResponsibility 
]

{ #category : #accessing }
CNBAbstractPattern >> elements [
	self subclassResponsibility 
]
