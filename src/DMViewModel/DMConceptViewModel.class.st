Class {
	#name : #DMConceptViewModel,
	#superclass : #Object,
	#instVars : [
		'classViewModels',
		'color',
		'conceptName',
		'size'
	],
	#category : #DMViewModel
}

{ #category : #accessing }
DMConceptViewModel >> classViewModels [
	^ classViewModels 
]

{ #category : #accessing }
DMConceptViewModel >> classViewModels: aCollectionOfClassViewModels [
	classViewModels := aCollectionOfClassViewModels 
]

{ #category : #accessing }
DMConceptViewModel >> color [ 
	^ color
]

{ #category : #accessing }
DMConceptViewModel >> color: aColor [
	color := aColor 
]

{ #category : #accessing }
DMConceptViewModel >> conceptName [
	^ conceptName
]

{ #category : #accessing }
DMConceptViewModel >> conceptName: aConcept [
	conceptName := aConcept 
]

{ #category : #accessing }
DMConceptViewModel >> size [
	^size
]

{ #category : #accessing }
DMConceptViewModel >> size: aSize [
	size := aSize
]
