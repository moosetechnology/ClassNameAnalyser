Class {
	#name : #DMViewModel,
	#superclass : #DMModel,
	#instVars : [
		'packageViewModels',
		'hierarchies',
		'name'
	],
	#category : #DMConceptualModel
}

{ #category : #'instance creation' }
DMViewModel >> from: aConceptualModel [

	^DMBuilder new buildViewModelFrom: aConceptualModel
	
]

{ #category : #accessing }
DMViewModel >> hierarchies [
	^hierarchies
]

{ #category : #accessing }
DMViewModel >> hierarchies: aCollectionOfRootClasses [
	hierarchies := aCollectionOfRootClasses 
]

{ #category : #initialization }
DMViewModel >> initialize [

	hierarchies := Dictionary new.
]

{ #category : #accessing }
DMViewModel >> name [ 
	^name
]

{ #category : #accessing }
DMViewModel >> name: aName [
	name := aName
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
