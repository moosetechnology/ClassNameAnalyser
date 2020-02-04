Class {
	#name : #DMPackageViewModel,
	#superclass : #DMModel,
	#instVars : [
		'name',
		'conceptViewModels'
	],
	#category : #DMModels
}

{ #category : #accessing }
DMPackageViewModel >> conceptViewModels [

	^conceptViewModels 
]

{ #category : #accessing }
DMPackageViewModel >> conceptViewModels: aConceptModelGroup [

	conceptViewModels := aConceptModelGroup 
]
