"
I am the package visualization model
"
Class {
	#name : #CNBPackageViewModel,
	#superclass : #CNBAbstractViewModel,
	#instVars : [
		'suffixViewModels',
		'size'
	],
	#category : #CNBModels
}

{ #category : #accessing }
CNBPackageViewModel >> models [
	^suffixViewModels 
]

{ #category : #accessing }
CNBPackageViewModel >> modelsOrderedAscending [
	^ suffixViewModels sorted: #size ascending
]

{ #category : #accessing }
CNBPackageViewModel >> modelsOrderedByColor [
	^CNBBuilder sort: suffixViewModels
]

{ #category : #accessing }
CNBPackageViewModel >> modelsOrderedDescending [

	^ suffixViewModels sorted: #size descending
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
CNBPackageViewModel >> suffixViewModels [
	^ suffixViewModels
]

{ #category : #accessing }
CNBPackageViewModel >> suffixViewModels: collectionOfConceptViewModels [
	suffixViewModels := collectionOfConceptViewModels.
	size := (collectionOfConceptViewModels flatCollect: #classViewModels) size
]
