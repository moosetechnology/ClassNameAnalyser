Class {
	#name : #DMClassModel,
	#superclass : #Object,
	#instVars : [
		'class',
		'rootClass',
		'conceptName'
	],
	#category : #DMConceptualModel
}

{ #category : #accessing }
DMClassModel >> classRef [
	^ class
]

{ #category : #setter }
DMClassModel >> classRef: aClass [
	class := aClass
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
