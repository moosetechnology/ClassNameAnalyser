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
	^DMBuilder sort: suffixViewModels
]

{ #category : #accessing }
CNBPackageViewModel >> modelsOrderedDescending [

	^ suffixViewModels sorted: #size descending
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
