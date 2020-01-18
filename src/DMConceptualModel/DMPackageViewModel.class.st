Class {
	#name : #DMPackageViewModel,
	#superclass : #DMModel,
	#instVars : [
		'name',
		'conceptViewModels'
	],
	#category : #DMConceptualModel
}

{ #category : #accessing }
DMPackageViewModel >> conceptViewModels [

	^conceptViewModels 
]

{ #category : #accessing }
DMPackageViewModel >> conceptViewModels: aConceptModelGroup [

	conceptViewModels := aConceptModelGroup 
]

{ #category : #accessing }
DMPackageViewModel >> name: aPackageName [

	name := aPackageName
]

{ #category : #'instance creation' }
DMPackageViewModel >> name: aName with: conceptModelGroup [

	self name: aName.
	self conceptViewModels: conceptModelGroup
]
