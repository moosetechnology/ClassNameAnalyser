"
I am the package visualization model
"
Class {
	#name : #CNBPackageViewModel,
	#superclass : #CNBAbstractViewModel,
	#instVars : [
		'size',
		'tokenViewModels'
	],
	#category : #CNBModels
}

{ #category : #accessing }
CNBPackageViewModel >> models [
	^tokenViewModels 
]

{ #category : #accessing }
CNBPackageViewModel >> modelsOrderedAscending [
	^ tokenViewModels sorted: #size ascending
]

{ #category : #accessing }
CNBPackageViewModel >> modelsOrderedByColor [
	 ^ CNBBuilder sort: tokenViewModels
]

{ #category : #accessing }
CNBPackageViewModel >> modelsOrderedDescending [

	^ tokenViewModels sorted: #size descending
]

{ #category : #'events-processing' }
CNBPackageViewModel >> processEvent: evt [

	Smalltalk tools browser openOnPackage:(RPackageOrganizer default packageNamed: name) 
]

{ #category : #accessing }
CNBPackageViewModel >> size [
	^ size
]

{ #category : #accessing }
CNBPackageViewModel >> tokenViewModels [
	^ tokenViewModels
]

{ #category : #accessing }
CNBPackageViewModel >> tokenViewModels: collectionOfTokenModels [
	tokenViewModels := collectionOfTokenModels.
	size := (collectionOfTokenModels flatCollect: #classViewModels) size
]
