Class {
	#name : #DMConceptualModel,
	#superclass : #Object,
	#instVars : [
		'packageModels',
		'packages'
	],
	#category : #DMConceptualModel
}

{ #category : #initialization }
DMConceptualModel >> initialize [ 

	packages := OrderedCollection new.
	packageModels := OrderedCollection new.
]

{ #category : #accessing }
DMConceptualModel >> packageModels [
	^ packageModels 
]

{ #category : #accessing }
DMConceptualModel >> packageModels: aCollectionOfPackageModels [
	packageModels := aCollectionOfPackageModels 
]
