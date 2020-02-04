Class {
	#name : #DMClassModel,
	#superclass : #DMModel,
	#instVars : [
		'name',
		'concept',
		'root',
		'superclass',
		'level',
		'reference'
	],
	#category : #DMModels
}

{ #category : #accessing }
DMClassModel >> concept [
	^concept
]

{ #category : #accessing }
DMClassModel >> concept: className [

	concept := DMFeatureSelector new extractConceptFrom: className
]

{ #category : #accessing }
DMClassModel >> level [
	^level
]

{ #category : #accessing }
DMClassModel >> level: aLevel [

	level := aLevel
]

{ #category : #accessing }
DMClassModel >> reference [
	^reference
]

{ #category : #accessing }
DMClassModel >> reference: aReference [

	reference := aReference
]

{ #category : #accessing }
DMClassModel >> root [
	^root
	
]

{ #category : #accessing }
DMClassModel >> root: aRoot [
	root := aRoot.
]

{ #category : #accessing }
DMClassModel >> superclass [
	^superclass
]

{ #category : #accessing }
DMClassModel >> superclass: aFamixClass [
	superclass := aFamixClass 
]
