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
DMPackageViewModel >> conceptViewModels: aConceptModelGroup [

	conceptViewModels := aConceptModelGroup 
]
