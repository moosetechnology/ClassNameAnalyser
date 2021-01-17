Class {
	#name : #DMViewModel,
	#superclass : #DMModel,
	#instVars : [
		'packageViewModels',
		'rootmodels'
	],
	#category : #DMModels
}

{ #category : #accessing }
DMViewModel >> models [
	^ packageViewModels 
]

{ #category : #'as yet unclassified' }
DMViewModel >> modelsOrderedAscending [
	^packageViewModels sorted: #size ascending
]

{ #category : #'as yet unclassified' }
DMViewModel >> modelsOrderedDescending [
	^ packageViewModels sorted: #size descending
]

{ #category : #accessing }
DMViewModel >> packageViewModels [
	^ packageViewModels 
]

{ #category : #accessing }
DMViewModel >> packageViewModels: collectionOfPackageViewModels [
 
	packageViewModels := collectionOfPackageViewModels 
]

{ #category : #accessing }
DMViewModel >> rootmodels [ 
	^rootmodels
]

{ #category : #accessing }
DMViewModel >> rootmodels: aCollectionOfRootClasses [
	rootmodels := aCollectionOfRootClasses 
]
