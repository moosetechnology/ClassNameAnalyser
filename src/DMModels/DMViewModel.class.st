Class {
	#name : #DMViewModel,
	#superclass : #DMModel,
	#instVars : [
		'packageViewModels',
		'rootmodels'
	],
	#category : #DMModels
}

{ #category : #initialization }
DMViewModel >> initialize [

	rootmodels := Dictionary new.
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
