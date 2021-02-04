Class {
	#name : #DMPackageViewModel,
	#superclass : #DMModel,
	#instVars : [
		'suffixViewModels',
		'size'
	],
	#category : #DMModels
}

{ #category : #'as yet unclassified' }
DMPackageViewModel >> modelsOrderedAscending [
	^suffixViewModels sorted: #size ascending
]

{ #category : #'as yet unclassified' }
DMPackageViewModel >> modelsOrderedByColor [
	^DMBuilder sort: suffixViewModels
]

{ #category : #'as yet unclassified' }
DMPackageViewModel >> modelsOrderedDescending [

	^ suffixViewModels sorted: #size descending
]

{ #category : #printing }
DMPackageViewModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'

	
]

{ #category : #accessing }
DMPackageViewModel >> size [
	^(suffixViewModels flatCollect: #classViewModels) size
]

{ #category : #accessing }
DMPackageViewModel >> suffixViewModels [
	^suffixViewModels
]

{ #category : #accessing }
DMPackageViewModel >> suffixViewModels: collectionOfConceptViewModels [
	suffixViewModels := collectionOfConceptViewModels.
	size := (collectionOfConceptViewModels flatCollect: #classViewModels) size
]
