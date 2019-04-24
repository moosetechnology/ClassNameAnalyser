Class {
	#name : #DMConceptualModel,
	#superclass : #Object,
	#instVars : [
		'packageModels'
	],
	#category : #DMConceptualModel
}

{ #category : #accessing }
DMConceptualModel >> packageModels [
	^ packageModels 
]

{ #category : #accessing }
DMConceptualModel >> packageModels: aCollectionOfPackageModels [
	packageModels := aCollectionOfPackageModels 
]
