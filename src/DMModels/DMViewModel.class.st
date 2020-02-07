Class {
	#name : #DMViewModel,
	#superclass : #DMModel,
	#instVars : [
		'packageViewModels',
		'rootmodels'
	],
	#category : #DMModels
}

{ #category : #'instance creation' }
DMViewModel >> from: aConceptualModel [

	^DMBuilder new buildViewModelFrom: aConceptualModel
	
]

{ #category : #initialization }
DMViewModel >> initialize [

	rootmodels := Dictionary new.
]

{ #category : #'instance creation' }
DMViewModel >> name: aName with: packagemodelGroup [

	self name: aName.
	self packageViewModels: packagemodelGroup
]

{ #category : #accessing }
DMViewModel >> packageViewModels [
	^ packageViewModels 
]

{ #category : #accessing }
DMViewModel >> packageViewModels: collectionOfPackageViewModels [

	packageViewModels := collectionOfPackageViewModels 
]

{ #category : #accessing }
DMViewModel >> rootmodels [ 
	^rootmodels
]

{ #category : #accessing }
DMViewModel >> rootmodels: aCollectionOfRootClasses [
	rootmodels := aCollectionOfRootClasses 
]
