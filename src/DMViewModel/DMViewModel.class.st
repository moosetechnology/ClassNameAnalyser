Class {
	#name : #DMViewModel,
	#superclass : #Object,
	#instVars : [
		'packageViewModels',
		'size'
	],
	#category : #DMViewModel
}

{ #category : #accessing }
DMViewModel >> packageViewModels [
	^ packageViewModels 
]

{ #category : #accessing }
DMViewModel >> packageViewModels: aCollectionOfPackageViewModels [
	packageViewModels := aCollectionOfPackageViewModels 
]

{ #category : #accessing }
DMViewModel >> size [ 
	^size
]

{ #category : #accessing }
DMViewModel >> size: aSize [
	size := aSize
]
