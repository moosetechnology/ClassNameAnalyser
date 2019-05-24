Class {
	#name : #DMPackageViewModel,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'conceptViewModels',
		'size'
	],
	#category : #DMViewModel
}

{ #category : #accessing }
DMPackageViewModel >> conceptViewModels [
	^ conceptViewModels
]

{ #category : #accessing }
DMPackageViewModel >> conceptViewModels: aCollectionOfConceptViewModels [
	conceptViewModels := aCollectionOfConceptViewModels 
]

{ #category : #accessing }
DMPackageViewModel >> packageName [ 
	^ packageName
]

{ #category : #accessing }
DMPackageViewModel >> packageRef [ 
	^ packageName
]

{ #category : #accessing }
DMPackageViewModel >> packageRef: aPackageName [
	packageName := aPackageName 
]

{ #category : #accessing }
DMPackageViewModel >> size [
	^size
]

{ #category : #accessing }
DMPackageViewModel >> size: aSize [
	size := aSize
]
