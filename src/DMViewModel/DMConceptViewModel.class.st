Class {
	#name : #DMConceptViewModel,
	#superclass : #Object,
	#instVars : [
		'title',
		'classViewModels',
		'color',
		'conceptsName',
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
DMConceptViewModel >> conceptsName [
	^ conceptsName
]

{ #category : #accessing }
DMConceptViewModel >> conceptsName: aConcept [
	conceptsName := aConcept 
]

{ #category : #accessing }
DMConceptViewModel >> size [
	^size
]

{ #category : #accessing }
DMConceptViewModel >> size: aSize [
	size := aSize
]
