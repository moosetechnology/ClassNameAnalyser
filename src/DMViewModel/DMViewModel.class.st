Class {
	#name : #DMViewModel,
	#superclass : #Object,
	#instVars : [
		'packageViewModels'
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
