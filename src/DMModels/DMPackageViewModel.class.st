Class {
	#name : #DMPackageViewModel,
	#superclass : #DMModel,
	#instVars : [
		'models',
		'size'
	],
	#category : #DMModels
}

{ #category : #accessing }
DMPackageViewModel >> conceptViewModels: aConceptModelGroup [

	models := aConceptModelGroup.
	size := ((models flatCollect: [ :eachConceptVModel | eachConceptVModel models ]) size)
]

{ #category : #accessing }
DMPackageViewModel >> models [

	^models 
]

{ #category : #'as yet unclassified' }
DMPackageViewModel >> modelsOrderedAscending [
	^models sorted: #size ascending
]

{ #category : #'as yet unclassified' }
DMPackageViewModel >> modelsOrderedByColor [
	^DMBuilder sort: models
]

{ #category : #'as yet unclassified' }
DMPackageViewModel >> modelsOrderedDescending [
	^ models sorted: #size descending
]

{ #category : #accessing }
DMPackageViewModel >> size [ 
	^size
]

{ #category : #accessing }
DMPackageViewModel >> size: aSize [
	size := aSize
]
