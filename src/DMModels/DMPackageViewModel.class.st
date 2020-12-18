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

{ #category : #accessing }
DMPackageViewModel >> size [ 
	^size
]

{ #category : #accessing }
DMPackageViewModel >> size: aSize [
	size := aSize
]
