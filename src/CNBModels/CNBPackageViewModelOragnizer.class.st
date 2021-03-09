Class {
	#name : #CNBPackageViewModelOragnizer,
	#superclass : #Object,
	#instVars : [
		'package'
	],
	#category : #CNBModels
}

{ #category : #'instance creation' }
CNBPackageViewModelOragnizer class >> of: aPackageModel [
	^ self new
		package: aPackageModel 
]

{ #category : #accessing }
CNBPackageViewModelOragnizer >> classes [
	^ package classModels
]

{ #category : #accessing }
CNBPackageViewModelOragnizer >> package [
	^ package
]

{ #category : #accessing }
CNBPackageViewModelOragnizer >> package: aPackageModel [
	package := aPackageModel 
]

{ #category : #'as yet unclassified' }
CNBPackageViewModelOragnizer >> rootNames [
	^ self classes collect: #root
]

{ #category : #'as yet unclassified' }
CNBPackageViewModelOragnizer >> selectRootsInside: aCollectionOfRoots [
	^ self classes collect: [ :each | aCollectionOfRoots includes: each root ]
]

{ #category : #accessing }
CNBPackageViewModelOragnizer >> tokens [ 
	^ self classes collect: #token
]
