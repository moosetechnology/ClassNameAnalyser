Class {
	#name : #CNBAbstractPattern,
	#superclass : #Object,
	#instVars : [
		'description',
		'condition'
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
