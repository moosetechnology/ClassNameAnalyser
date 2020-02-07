Class {
	#name : #DMConceptViewModel,
	#superclass : #DMModel,
	#instVars : [
		'classViewModels',
		'color',
		'root'
	],
	#category : #DMModels
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

{ #category : #'instance creation' }
DMConceptViewModel >> name: aConceptName with: classVMs [

	self name: aConceptName.
	self classViewModels: classVMs.
]

{ #category : #accessing }
DMConceptViewModel >> root [
	^root
]

{ #category : #accessing }
DMConceptViewModel >> root: biggestHierarchy [
	root := biggestHierarchy
]
