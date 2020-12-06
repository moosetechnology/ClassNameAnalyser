Class {
	#name : #DMPackageViewModel,
	#superclass : #DMModel,
	#instVars : [
		'conceptViewModels',
		'size'
	],
	#category : #DMModels
}

{ #category : #accessing }
DMPackageViewModel >> conceptViewModels [

	^conceptViewModels 
]

{ #category : #accessing }
DMPackageViewModel >> conceptViewModels: aConceptModelGroup [

	conceptViewModels := aConceptModelGroup.
	size := ((conceptViewModels flatCollect: [ :eachConceptVModel | eachConceptVModel classViewModels ]) size)
]

{ #category : #accessing }
DMPackageViewModel >> size [ 
	^size
]

{ #category : #accessing }
DMPackageViewModel >> size: aSize [
	size := aSize
]
