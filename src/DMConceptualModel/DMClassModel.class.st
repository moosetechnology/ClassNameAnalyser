Class {
	#name : #DMClassModel,
	#superclass : #Object,
	#instVars : [
		'class',
		'concept',
		'rootClass'
	],
	#category : #DMConceptualModel
}

{ #category : #accessing }
DMClassModel >> concept [
	^ concept 
]

{ #category : #setter }
DMClassModel >> concept: aConcept [
	concept := aConcept
]

{ #category : #accessing }
DMClassModel >> rootClass [ 
	^ rootClass 
	
]

{ #category : #setter }
DMClassModel >> rootClass: aRootClass [
	rootClass := aRootClass.
]

{ #category : #accessing }
DMClassModel >> theClass [
	^ class
]

{ #category : #setter }
DMClassModel >> theClass: aClass [
	class := aClass
]
