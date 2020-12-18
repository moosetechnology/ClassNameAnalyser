Class {
	#name : #DMViewModel,
	#superclass : #DMModel,
	#instVars : [
		'models',
		'rootmodels'
	],
	#category : #DMModels
}

{ #category : #initialization }
DMViewModel >> initialize [

	rootmodels := Dictionary new.
]

{ #category : #accessing }
DMViewModel >> models [
	^ models 
]

{ #category : #accessing }
DMViewModel >> packageViewModels: collectionOfPackageViewModels [

	models := collectionOfPackageViewModels 
]

{ #category : #accessing }
DMViewModel >> rootmodels [ 
	^rootmodels
]

{ #category : #accessing }
DMViewModel >> rootmodels: aCollectionOfRootClasses [
	rootmodels := aCollectionOfRootClasses 
]
