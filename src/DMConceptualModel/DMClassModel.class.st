Class {
	#name : #DMClassModel,
	#superclass : #Object,
	#instVars : [
		'class',
		'concept',
		'rootClass',
		'theConcept'
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
DMClassModel >> concept [
	^ theConcept 
]

{ #category : #setter }
DMClassModel >> concept: aConcept [
	theConcept := aConcept
]

{ #category : #accessing }
DMClassModel >> rootClass [ 
	^ rootClass 
	
]

{ #category : #setter }
DMClassModel >> rootClass: aRootClass [
	rootClass := aRootClass.
]
