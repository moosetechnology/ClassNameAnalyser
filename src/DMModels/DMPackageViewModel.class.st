Class {
	#name : #DMPackageViewModel,
	#superclass : #DMModel,
	#instVars : [
		'conceptViewModels'
	],
	#category : #DMModels
}

{ #category : #accessing }
DMPackageViewModel >> conceptViewModels [
	^conceptViewModels
]

{ #category : #accessing }
DMPackageViewModel >> conceptViewModels: collectionOfConceptViewModels [
	conceptViewModels := collectionOfConceptViewModels 
]

{ #category : #'as yet unclassified' }
DMPackageViewModel >> modelsOrderedAscending [
	^conceptViewModels sorted: #size ascending
]

{ #category : #'as yet unclassified' }
DMPackageViewModel >> modelsOrderedByColor [
	^DMBuilder sort: conceptViewModels
]

{ #category : #'as yet unclassified' }
DMPackageViewModel >> modelsOrderedDescending [
	^ conceptViewModels sorted: #size descending
]

{ #category : #printing }
DMPackageViewModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'

	
]
