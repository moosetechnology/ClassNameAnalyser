Class {
	#name : #DMClassModel,
	#superclass : #Object,
	#instVars : [
		'classRef',
		'rootClass',
		'conceptName'
	],
	#category : #DMConceptualModel
}

{ #category : #accessing }
DMClassModel >> classRef [
	^ classRef
]

{ #category : #setter }
DMClassModel >> classRef: aClass [
	classRef := aClass
]

{ #category : #accessing }
DMClassModel >> conceptName [
	^ conceptName 
]

{ #category : #setter }
DMClassModel >> conceptName: aConcept [
	conceptName := aConcept
]

{ #category : #accessing }
DMClassModel >> rootClass [ 
	^ rootClass 
	
]

{ #category : #setter }
DMClassModel >> rootClass: aRootClass [
	rootClass := aRootClass.
]
